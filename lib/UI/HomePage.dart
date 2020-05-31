import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:miproject/Data/Auth.dart';
import 'package:miproject/Data/UserSingleton.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState(){
    updateUserDetails().then((value) => setState((){}));
    super.initState();
  }

  Future updateUserDetails() async{
    await FirebaseAuth.instance.currentUser().then((user) {
      UserSingleton().fireUser = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text("MiProject"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: GestureDetector(
              child: Icon(Icons.exit_to_app),
              onTap: () async => await Auth.logoutUser(),
            ),
          )
        ],
      ),
      body: Center(child: Text("Welcome")),
    );
  }
}
