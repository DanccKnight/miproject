import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:miproject/UI/AboutPage.dart';
import 'package:miproject/UI/HomePage.dart';
import 'package:miproject/UI/SignInPage.dart';
import 'package:miproject/UI/DisplayVitalsPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  onAuthStateChanged() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (BuildContext context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Container(child: Center(child: Text('Hmm, interesting...')));
            case ConnectionState.waiting:
              return Center(child: Center(child: CircularProgressIndicator()));
            case ConnectionState.active:
            case ConnectionState.done:
              if (snapshot.hasData) return HomePage();
          }
          return SignInPage();
        });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: onAuthStateChanged(),
      routes: <String,WidgetBuilder>{
        '/SignInPage': (BuildContext context) => SignInPage(),
        '/HomePage': (BuildContext context) => HomePage(),
        '/DisplayVitalsPage': (BuildContext context) => DisplayVitalsPage(),
        '/AboutPage': (BuildContext context) => AboutPage()
      },
    );
  }
}
