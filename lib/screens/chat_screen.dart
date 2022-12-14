import 'package:chat_app/components/bubble.dart';
import 'package:chat_app/screens/welcome_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/constants.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;
User? loggedInUser;

class ChatScreen extends StatefulWidget {
  static const String id = 'ChatScreen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String message = '';

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    try {
      loggedInUser = _auth.currentUser;
      //print('Current User: ${user?.email}');
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () async {
                //Implement logout functionality
                await _auth.signOut();
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                } else {
                  Navigator.pushNamed(context, WelcomeScreen.id);
                }
              }),
        ],
        title: Text('Simple Chat App'),
        backgroundColor: primary1,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(child: MessageBubblesBuilder()),
            Container(
              padding: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 15,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: TextEditingController(text: message),
                      style: TextStyle(
                        color: text1,
                      ),
                      onChanged: (value) {
                        //Do something with the user input.
                        message = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      //Implement send functionality.
                      await _firestore.collection('messages').add({
                        'msg': message,
                        'sender': loggedInUser?.email,
                        'created_at': DateTime.now(),
                      });
                      setState(() {
                        message = '';
                      });
                    },
                    child: Icon(
                      Icons.send,
                      color: accent,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageBubblesBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream:
          _firestore.collection('messages').orderBy('created_at').snapshots(),
      builder: (context, asyncSnapshot) {
        if (!asyncSnapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        List<MessageBubble> messageBubbles = [];

        var snapshot = asyncSnapshot.data;

        for (var message in snapshot!.docs) {
          String messageSender = message.get('sender');
          String messageText = message.get('msg');

          messageBubbles.add(
            MessageBubble(
              sender: messageSender,
              message: messageText,
              isMe: loggedInUser?.email == messageSender,
            ),
          );
        }

        return ListView(
          padding: EdgeInsets.only(bottom: 10),
          children: messageBubbles,
        );
      },
    );
  }
}

class MessageBubble extends StatelessWidget {
  final String sender;
  final String message;
  //used to differentiate the messages of the current user from the counterpart
  final bool isMe;
  static String? lastSender;

  static bool lastSenderState = false;

  //late Color counterpartColor;
  //Map<bool, Color> counterpart = {false: primary1, true: primary2};
  Set<ColorSwatch<int>> colorList = {
    Colors.orangeAccent,
    Colors.blue,
    Colors.pinkAccent,
    Colors.green,
    Colors.brown,
    Colors.purpleAccent,
    Colors.yellow,
    Colors.cyan,
    Colors.red,
    Colors.lightGreen
  };
  static int nextColorIndex = 0;
  Color nextColor() {
    if (nextColorIndex == colorList.length) {
      nextColorIndex = 0;
    }
    return colorList.elementAt(nextColorIndex++);
  }

  bool isFirstSenderMessage = false;

  MessageBubble(
      {required this.sender, required this.message, required this.isMe}) {
    if (!isMe && lastSender != null && lastSender != sender) {
      lastSenderState = !lastSenderState;
    }
    //counterpartColor = counterpart[lastSenderState]!;

    isFirstSenderMessage = lastSender == null || sender != lastSender;

    lastSender = sender;
  }

  @override
  Widget build(BuildContext context) {
    return Bubble(
      isFirst: isFirstSenderMessage,
      title: sender,
      titleColor: isMe ? text2 : nextColor(),
      content: message,
      backgroundColor: isMe ? accent : primary2,
      contentColor: isMe ? text3 : text1,
      toRight: isMe,
    );
  }
}
