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
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: FlutterLogo(size: 150),
              ),
              Container(
                  padding: EdgeInsets.fromLTRB(70.0, 100.0, 70.0, 0.0),
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(30.0),
                    color: Colors.blue,
                    child: MaterialButton(
                      minWidth: MediaQuery.of(context).size.width,
                      onPressed: () async {
                        await Auth.signInWithGoogle().then((value) {
                          value == true
                              ? Navigator.of(context)
                              .pushReplacementNamed('/HomePage')
                              : Scaffold.of(context).showSnackBar(
                              SnackBar(content: Text("Signin failed")));
                        });
                      },
                      child: Text("Login with Google",
                          textAlign: TextAlign.center,
                          style: TextStyle().copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ),
                  )),
            ]),
      ),
    );
  }
}