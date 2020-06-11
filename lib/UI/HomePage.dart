import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:miproject/Data/Auth.dart';
import 'package:miproject/Data/UserSingleton.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    if(UserSingleton().fireUser ==  null){
      updateUserDetails().then((value) => setState((){}));
    }
    super.initState();
  }

  Future updateUserDetails() async {
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
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.all(0),
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: UserSingleton().fireUser == null
                    ? Text('name')
                    : Text(UserSingleton().fireUser.displayName),
                accountEmail: UserSingleton().fireUser == null
                    ? Text('email')
                    : Text(UserSingleton().fireUser.email),
                currentAccountPicture: GestureDetector(
                  child: UserSingleton().fireUser == null
                      ? CircleAvatar(
                    backgroundColor: Colors.blue,
                  )
                      : CircleAvatar(
                      backgroundImage:
                      NetworkImage(UserSingleton().fireUser.photoUrl)),
                ),
              ),
              ListTile(
                leading: Icon(Icons.info),
                title: Text("About"),
                onTap: null,
              ),
              ListTile(
                leading: Icon(Icons.add),
                title: Text("Add Patient"),
                onTap: null,
              ),
              ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text("Sign out"),
                onTap: () {
                  Auth.logoutUser().then((value) => Navigator.of(context)
                      .pushReplacementNamed('/SignInPage'));
                },
              ),
            ],
          ),
        ),
        body: Center(child: Text("Haha"))
    );
  }
}

class MessageHandler extends StatefulWidget {
  @override
  _MessageHandlerState createState() => _MessageHandlerState();
}

class _MessageHandlerState extends State<MessageHandler> {
  final FirebaseMessaging _fcm = FirebaseMessaging();

  @override
  void initState() {
    super.initState();
    _fcm.configure(
      //Called when app is in foreground and we get a notification
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        /*final snackbar = SnackBar(
          content: Text(message['notification']['title']),
          action: SnackBarAction(
              label: 'Go',
              onPressed: () =>
                  Navigator.of(context).pushNamed('/DescriptionPage')),
        );
        Scaffold.of(context).showSnackBar(snackbar);*/
      },
      //Called when app is in the background
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        /*Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => DescriptionPage()));*/
      },
      //Called when app is terminated and we get a notiification
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        /*Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => DescriptionPage()));*/
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return null;
  }
}