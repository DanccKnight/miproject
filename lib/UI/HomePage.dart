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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var ageController = TextEditingController();
  var genderController = TextEditingController();
  var phoneNoController = TextEditingController();
  var deviceIdController = TextEditingController();
  var roomNoController = TextEditingController();
  var relativeContactController = TextEditingController();
  var bloodGroupController = TextEditingController();
  int currStep = 0;

  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    genderController.dispose();
    phoneNoController.dispose();
    deviceIdController.dispose();
    roomNoController.dispose();
    relativeContactController.dispose();
    bloodGroupController.dispose();
    super.dispose();
  }

  showAlert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text("Please fill all the fields before uploading"),
          );
        });
  }

  showSuccessMessage() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text("Details uploaded successfully!"),
          );
        });
  }

  List<Step> getSteps() {
    return [
      Step(
          title: const Text('Name'),
          isActive: true,
          state: StepState.indexed,
          content: TextFormField(
            controller: nameController,
            validator: (input) {
              if (input.isEmpty) {
                return "Please enter a name";
              } else {
                return null;
              }
            },
            maxLines: 1,
            decoration: InputDecoration(
                labelText: 'Enter name',
                icon: const Icon(Icons.person),
                labelStyle:
                TextStyle(decorationStyle: TextDecorationStyle.solid)),
          )),
      Step(
          title: const Text('Age'),
          isActive: true,
          state: StepState.indexed,
          content: TextFormField(
            controller: ageController,
            keyboardType: TextInputType.numberWithOptions(),
            validator: (input) {
              if (input.isEmpty) {
                return "Please enter an age";
              } else {
                return null;
              }
            },
            maxLines: 1,
            decoration: InputDecoration(
                labelText: 'Enter age',
                icon: const Icon(Icons.drag_handle),
                labelStyle:
                TextStyle(decorationStyle: TextDecorationStyle.solid)),
          )),
      Step(
          title: const Text('Gender'),
          isActive: true,
          state: StepState.indexed,
          content: TextFormField(
            controller: genderController,
            validator: (input) {
              if (input.isEmpty) {
                return "Please enter your gender";
              } else {
                return null;
              }
            },
            maxLines: 1,
            decoration: InputDecoration(
                labelText: 'Enter gender',
                icon: const Icon(Icons.menu),
                labelStyle:
                TextStyle(decorationStyle: TextDecorationStyle.solid)),
          )),
      Step(
          title: const Text('Blood Group'),
          isActive: true,
          state: StepState.indexed,
          content: TextFormField(
            controller: bloodGroupController,
            validator: (input) {
              if (input.isEmpty) {
                return "Please enter a valid blood group";
              } else {
                return null;
              }
            },
            maxLines: 1,
            decoration: InputDecoration(
                labelText: 'Enter blood group',
                icon: const Icon(Icons.local_hospital),
                labelStyle:
                TextStyle(decorationStyle: TextDecorationStyle.solid)),
          )),
      Step(
          title: const Text('Phone number'),
          isActive: true,
          state: StepState.indexed,
          content: TextFormField(
            controller: phoneNoController,
            keyboardType: TextInputType.numberWithOptions(),
            validator: (input) {
              if (input.isEmpty) {
                return "Please enter the phone number";
              } else if (input.length != 10) {
                return 'Invalid number';
              } else {
                return null;
              }
            },
            maxLines: 1,
            decoration: InputDecoration(
                labelText: 'Enter phone number',
                icon: const Icon(Icons.phone),
                labelStyle:
                TextStyle(decorationStyle: TextDecorationStyle.solid)),
          )),
      Step(
          title: const Text('Room no'),
          isActive: true,
          state: StepState.indexed,
          content: TextFormField(
            keyboardType: TextInputType.numberWithOptions(),
            controller: roomNoController,
            validator: (input) {
              if (input.isEmpty) {
                return "Please enter the room no alloted";
              } else {
                return null;
              }
            },
            maxLines: 1,
            decoration: InputDecoration(
                labelText: 'Enter room no',
                icon: const Icon(Icons.room),
                labelStyle:
                TextStyle(decorationStyle: TextDecorationStyle.solid)),
          )),
      Step(
          title: const Text('Device ID'),
          isActive: true,
          state: StepState.indexed,
          content: TextFormField(
            controller: deviceIdController,
            validator: (input) {
              if (input.isEmpty) {
                return "Please enter the device id";
              } else {
                return null;
              }
            },
            maxLines: 1,
            decoration: InputDecoration(
                labelText: 'Enter device id',
                icon: const Icon(Icons.devices),
                labelStyle:
                TextStyle(decorationStyle: TextDecorationStyle.solid)),
          )),
      Step(
          title: const Text('Relative Contact'),
          isActive: true,
          state: StepState.indexed,
          content: TextFormField(
            controller: relativeContactController,
            keyboardType: TextInputType.numberWithOptions(),
            validator: (input) {
              if (input.isEmpty) {
                return "Please enter your close relatives number";
              } else if (input.length != 10) {
                return 'Invalid number';
              } else {
                return null;
              }
            },
            maxLines: 1,
            decoration: InputDecoration(
                labelText: 'Enter relatives number',
                icon: const Icon(Icons.people),
                labelStyle:
                TextStyle(decorationStyle: TextDecorationStyle.solid)),
          )),
    ];
  }

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
                          child: Text("Welcome to our family \nof caretakers!",
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
              onTap: (){
                Navigator.of(context).popAndPushNamed('/AboutPage');
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
          : currentIndex == 1 ? displayPatients() : displayForm(),
      floatingActionButton: currentIndex != 2 ? null : FloatingActionButton(
          child: Icon(Icons.check),
          onPressed: () async {
            if (_formKey.currentState.validate()) {
              Firestore.instance
                  .collection('Patients')
                  .document(deviceIdController.text)
                  .setData({
                'name': nameController.text,
                'age': ageController.text,
                'gender': genderController.text,
                'room_no': roomNoController.text,
                'device_id': deviceIdController.text,
                'phone_no': phoneNoController.text,
                'relative_contact': relativeContactController.text,
                'blood_group': bloodGroupController.text
              }).then((value) {
                relativeContactController.clear();
                phoneNoController.clear();
                deviceIdController.clear();
                bloodGroupController.clear();
                roomNoController.clear();
                genderController.clear();
                ageController.clear();
                nameController.clear();
                showSuccessMessage();
              });
            } else {
              showAlert();
            }
          }),
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
                  Icons.person_add,
                  color: Colors.black,
                ),
                icon: Icon(
                  Icons.person_add,
                  color: Colors.grey,
                ),
                title: Text("Add Patient",
                    style: TextStyle(
                        color: currentIndex == 2 ? Colors.black : Colors.grey)),
                backgroundColor: Colors.black)
          ]),
    );
  }

  Widget displayPatients() {
    return SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
            Widget>[
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
                    padding: const EdgeInsets.only(left: 15, top: 50),
                    child: SvgPicture.asset(
                      "Assets/images/hmm.svg",
                      width: 230,
                      fit: BoxFit.fitWidth,
                      alignment: Alignment.topCenter,
                    ),
                  ),
                  Positioned(
                      top: 80,
                      left: MediaQuery.of(context).size.width - 230,
                      child: Text("Monitor the health of \nthe elderly",
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
          width: 90,
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.12),
              borderRadius: BorderRadius.circular(8)),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Text("Patients",
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                )),
          ),
        ),
      ),
      StreamBuilder(
        stream: Firestore.instance.collection('Patients').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          return GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(15),
                  child: GestureDetector(
                    onTap: (){
                      Navigator.of(context).pushNamed('/DisplayVitalsPage');
                    },
                    child: Card(
                        child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Container(
                              height: 90,
                              width: 90,
                              child: snapshot.data.documents[index]["gender"] == "Male" ? SvgPicture.asset("Assets/images/male.svg") : SvgPicture.asset("Assets/images/female.svg")),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: 10, left: 10, right: 10),
                          child: Text(snapshot.data.documents[index]["name"],
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  .copyWith(color: Colors.black,fontSize: 18
                              )
                          ),
                        )
                      ],
                    )),
                  ),
                );
              });
        },
      )
    ]));
  }

  Widget displayForm(){
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
                        padding: const EdgeInsets.only(left: 20, top: 50),
                        child: SvgPicture.asset(
                          "Assets/images/hmm.svg",
                          width: 230,
                          fit: BoxFit.fitWidth,
                          alignment: Alignment.topCenter,
                        ),
                      ),
                      Positioned(
                          top: 100,
                          left: MediaQuery.of(context).size.width - 210,
                          child: Text(
                              "Be sure to fill all \nthe fields correctly!",
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
              height: 35,
              width: 140,
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(8)),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Text("Patient Details",
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    )),
              ),
            ),
          ),
          Form(
            key: _formKey,
            child: Stepper(
              physics: NeverScrollableScrollPhysics(),
              steps: getSteps(),
              type: StepperType.vertical,
              currentStep: this.currStep,
              onStepContinue: () {
                setState(() {
                  if (currStep < getSteps().length - 1) {
                    currStep = currStep + 1;
                  } else {
                    currStep = 0;
                  }
                });
              },
              onStepCancel: () {
                setState(() {
                  if (currStep > 0) {
                    currStep = currStep - 1;
                  } else {
                    currStep = 0;
                  }
                });
              },
              onStepTapped: (step) {
                setState(() {
                  currStep = step;
                });
              },
              controlsBuilder: currStep != (getSteps().length - 1)
                  ? null
                  : (BuildContext context,
                  {VoidCallback onStepContinue,
                    VoidCallback onStepCancel}) =>
                  Container(),
            ),
          ),
        ],
      ),
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
