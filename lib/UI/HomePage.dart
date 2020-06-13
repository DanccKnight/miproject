import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:miproject/Data/Auth.dart';
import 'package:miproject/Data/UserSingleton.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  @override
  void initState() {
    if (UserSingleton().fireUser == null) {
      updateUserDetails().then((value) => setState(() {}));
    }
    super.initState();
  }

  Future updateUserDetails() async {
    await FirebaseAuth.instance.currentUser().then((user) {
      UserSingleton().fireUser = user;
    });
  }

  Widget displayHome() {
    return SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
          ClipPath(
            clipper: MyClipper(),
            child: Container(
              padding: const EdgeInsets.all(0),
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [Color(0xFF3383CD), Color(0xFF11249F)])),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Stack(children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 0, top: 50),
                        child: SvgPicture.asset(
                          "Assets/images/dr.svg",
                          width: 230,
                          fit: BoxFit.fitWidth,
                          alignment: Alignment.topCenter,
                        ),
                      ),
                      Positioned(
                          top: 80,
                          left: MediaQuery.of(context).size.width - 230,
                          child: Text(
                              "Welcome to our family \nof caretakers!",
                              style: TextStyle(
                                fontSize: 22,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ))),
                      Container()
                    ]),
                  )
                ],
              ),
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    miniCard('Total Incidents \nOccured', 58),
                    miniCard("Incidents in the \npast week", 18),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  height: 175,
                  width: double.infinity,
                  child: Stack(
                    alignment: Alignment.bottomLeft,
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.4,
                            top: 15),
                        height: 155,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [Color(0xFF3383CD), Color(0xFF11249F)]),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text: "Dial 102 for \nmedical help!\n",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  .copyWith(color: Colors.white)),
                          TextSpan(
                              text: "\nIn case of severe incidents",
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.8)))
                        ])),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: SvgPicture.asset("Assets/images/nurse.svg"),
                      )
                    ],
                  ),
                ),
              )
            ],
          )
        ]));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.all(0),
          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                  color: Color(0xFF11249F),
                  gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Color(0xFF3383CD),
                        Colors.blue.withOpacity(0.85)
                      ])),
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
              leading: Icon(Icons.person_add),
              title: Text("Add Patient"),
              onTap: () {
                Navigator.popAndPushNamed(context, '/AddPatientPage');
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text("Sign out"),
              onTap: () {
                Auth.logoutUser().then((value) =>
                    Navigator.of(context).pushReplacementNamed('/SignInPage'));
              },
            ),
          ],
        ),
      ),
      body: currentIndex == 0
          ? displayHome()
          : currentIndex == 1
              ? Center(child: Text("Patients"))
              : displayAbout(),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          elevation: 10,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              activeIcon: Icon(
                Icons.home,
                color: Colors.black,
              ),
              icon: Icon(Icons.home),
              title: Text("Home",
                  style: TextStyle(
                      color: currentIndex == 0 ? Colors.black : Colors.grey)),
            ),
            BottomNavigationBarItem(
                activeIcon: Icon(
                  Icons.people,
                  color: Colors.black,
                ),
                icon: Icon(
                  Icons.people,
                  color: Colors.grey,
                ),
                title: Text("Patients",
                    style: TextStyle(
                        color: currentIndex == 1 ? Colors.black : Colors.grey)),
                backgroundColor: Colors.black),
            BottomNavigationBarItem(
                activeIcon: Icon(
                  Icons.info,
                  color: Colors.black,
                ),
                icon: Icon(
                  Icons.info,
                  color: Colors.grey,
                ),
                title: Text("About",
                    style: TextStyle(
                        color: currentIndex == 2 ? Colors.black : Colors.grey)),
                backgroundColor: Colors.black)
          ]),
    );
  }

  Widget displayAbout() {
    return SingleChildScrollView(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ClipPath(
              clipper: MyClipper(),
              child: Container(
                padding: const EdgeInsets.all(0),
                height: 300,
                width: double.infinity,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [Color(0xFF3383CD), Color(0xFF11249F)])),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Stack(children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 0, top: 50),
                          child: SvgPicture.asset(
                            "Assets/images/dr.svg",
                            width: 230,
                            fit: BoxFit.fitWidth,
                            alignment: Alignment.topCenter,
                          ),
                        ),
                        Positioned(
                            top: 80,
                            left: MediaQuery.of(context).size.width - 230,
                            child: Text("Get to know more \nabout us!",
                                style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ))),
                        Container()
                      ]),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25),
              child: Container(
                height: 40,
                width: 130,
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(8)),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text("Our Mission",
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      )),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              child: Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    "Many believe that it is our moral obligation to look after our elders, and we share your views. We feel that it is our duty to care for our elders responsibly, to treat them with dignity and to provide them with the highest level of care possible.",
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .copyWith(fontSize: 16),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25,top: 10),
              child: Container(
                height: 40,
                width: 130,
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(8)),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text("Our Services",
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      )),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              child: Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    "We make use of cutting edge technology to provide holistic care that focuses on all aspects of an elderly's life. We believe in respecting others privacy, so we built our services in accordance with these views. Our systems run 24x7, without intruding on the privacy of the citizens.",
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .copyWith(fontSize: 16),
                  ),
                ),
              ),
            )
          ]),
    );
  }

  Widget miniCard(String heading, int num) {
    return Card(
      elevation: 4,
      child: Container(
        height: 110,
        width: 160,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12, top: 15),
              child: Row(
                children: <Widget>[
                  Container(
                    child: SvgPicture.asset("Assets/images/increase.svg"),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    height: 12,
                    width: 12,
                  ),
                  SizedBox(width: 12),
                  Text(
                    heading,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 35, top: 10),
                  child: RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: num.toString(),
                        style: Theme.of(context).textTheme.headline6.copyWith(
                            fontSize: 26, fontWeight: FontWeight.bold)),
                  ])),
                ),
              ],
            )
          ],
        ),
      ),
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
        print(message['notification']['title']);
      },
      //Called when app is in the background
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
      //Called when app is terminated and we get a notification
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return null;
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 80);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 80);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
