import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:miproject/UI/HomePage.dart';

class AddPatientPage extends StatefulWidget {
  @override
  _AddPatientPageState createState() => _AddPatientPageState();
}

class _AddPatientPageState extends State<AddPatientPage> {
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ClipPath(
              clipper: MyClipper(),
              child: Container(
                padding: const EdgeInsets.all(0),
                height: 320,
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
                          padding: const EdgeInsets.only(left: 20,top: 50),
                          child: SvgPicture.asset("Assets/images/hmm.svg",
                            width: 230,
                            fit: BoxFit.fitWidth,
                            alignment: Alignment.topCenter,
                          ),
                        ),
                        Positioned(
                            top: 100,
                            left: MediaQuery.of(context).size.width - 210,
                            child: Text("Be sure to fill all \nthe fields correctly!",style: TextStyle(
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
                    borderRadius: BorderRadius.circular(8)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text("Patient Details",style: TextStyle(
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
      ),
      floatingActionButton: FloatingActionButton(
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
    );
  }
}