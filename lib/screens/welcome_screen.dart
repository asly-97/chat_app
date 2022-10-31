import 'package:chat_app/constants.dart';
import 'package:chat_app/screens/login_screen.dart';
import 'package:chat_app/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/components/rounded_button.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'WelcomeScreen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  late AnimationController imgCtr;

  late AnimationController txtCtr;
  late Animation txtAnim;

  late AnimationController bgCtr;
  late Animation bgAnim;

  @override
  void initState() {
    super.initState();

    //Animation for Logo image
    imgCtr = AnimationController(duration: Duration(seconds: 2), vsync: this);
    imgCtr.forward();
    imgCtr.addListener(() => setState(() {}));

    //Animation for text 'Chat App'
    txtCtr = AnimationController(vsync: this, duration: Duration(seconds: 2));
    txtCtr.addListener(() => setState(() {}));
    txtCtr.forward();
    txtAnim = CurvedAnimation(parent: txtCtr, curve: Curves.bounceOut);

    //Animation for background color
    bgCtr = AnimationController(duration: Duration(seconds: 1), vsync: this);
    bgCtr.addListener(() => setState(() {}));
    bgCtr.forward();
    bgAnim = ColorTween(begin: background3, end: background1).animate(bgCtr);
  }

  @override
  void dispose() {
    super.dispose();
    imgCtr.dispose();
    bgCtr.dispose();
    txtCtr.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgAnim.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'login',
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        'images/logo.png',
                        color: accent.withOpacity(imgCtr.value),
                      ),
                    ),
                    height: 60.0,
                  ),
                ),
                Text(
                  'Chat App',
                  style: TextStyle(
                      fontSize: txtAnim.value * 45.0,
                      fontWeight: FontWeight.w900,
                      color: text1),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            RoundedButton(
              title: 'Log In',
              color: primary1,
              onClick: () => Navigator.pushNamed(context, LoginScreen.id),
            ),
            RoundedButton(
              title: 'Register',
              color: primary2,
              onClick: () =>
                  Navigator.pushNamed(context, RegistrationScreen.id),
            ),
          ],
        ),
      ),
    );
  }
}
