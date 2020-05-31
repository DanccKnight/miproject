import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:miproject/Data/Auth.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 40,
            child: SignInButton(Buttons.GoogleDark, onPressed: () async {
              await Auth.signInWithGoogle().then((value) {
                value == true
                    ? Navigator.of(context).pushReplacementNamed('/HomePage')
                    : Scaffold.of(context)
                        .showSnackBar(SnackBar(content: Text("Signin failed!")));
              });
            }),
          )
        ],
      )),
    );
  }
}
