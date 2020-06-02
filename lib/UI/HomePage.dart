import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:miproject/Data/Auth.dart';
import 'package:miproject/Data/User.dart';
import 'package:miproject/Data/UserSingleton.dart';
import 'package:miproject/UI/AdminPage.dart';
import 'package:miproject/UI/PatientPage.dart';

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
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: GestureDetector(
                child: Icon(Icons.exit_to_app),
                onTap: () async => await Auth.logoutUser().then(
                        (value) => Navigator.pushReplacementNamed(context, '/SignInPage')),
              ),
            )
          ],
        ),
        body: StreamBuilder(
          stream: Firestore.instance.collection('Users').document(UserSingleton().fireUser.uid).snapshots(),
          builder: (context,snapshot){
            if(!snapshot.hasData){
              return Center(child: CircularProgressIndicator());
            }
            else if(snapshot.data['isAdmin'] == true) {
              return AdminPage();
            }
            else {
              return PatientPage();
            }
          },
        )
    );
  }

}
