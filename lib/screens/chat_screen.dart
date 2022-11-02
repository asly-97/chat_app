import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/constants.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class ChatScreen extends StatefulWidget {
  static const String id = 'ChatScreen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  User? user;

  String message = '';

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    try {
      user = _auth.currentUser;
      //print('Current User: ${user?.email}');
    } catch (e) {
      print(e);
    }
  }

  void getStreamMessages() async {
    await for (var snapshot in _firestore.collection('messages').snapshots()) {
      for (var doc in snapshot.docs) {
        print(doc.data());
      }
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
                Navigator.pop(context);
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: primary2,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(child: MessageBubblesBuilder()),
            Container(
              decoration: kMessageContainerDecoration,
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
                        'sender': user?.email,
                      });
                      setState(() {
                        message = '';
                      });
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
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
      stream: _firestore.collection('messages').snapshots(),
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
            ),
          );
        }
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: ListView(
            children: messageBubbles,
          ),
        );
      },
    );
  }
}

class MessageBubble extends StatelessWidget {
  final String sender;
  final String message;

  MessageBubble({required this.sender, required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            sender,
            style: TextStyle(
              color: text2,
            ),
          ),
          Material(
            elevation: 5,
            borderRadius: BorderRadius.circular(20),
            color: primary1,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text(
                message,
                style: TextStyle(
                  color: text1,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
