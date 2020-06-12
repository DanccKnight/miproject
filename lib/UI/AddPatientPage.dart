import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
          title: const Text('Phone number'),
          isActive: true,
          state: StepState.indexed,
          content: TextFormField(
            controller: ageController,
            keyboardType: TextInputType.numberWithOptions(),
            validator: (input) {
              if (input.isEmpty) {
                return "Please enter the phone number";
              } else if(input.length != 10){
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
              } else if(input.length != 10){
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
      appBar: AppBar(
        /*leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),*/
        title: Text(
          "Add new patient",
        ),
      ),
      body: SingleChildScrollView(
          child: Form(
        key: _formKey,
        child: ListView(children: <Widget>[
          Stepper(
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
                print(currStep);
              });
            },
            controlsBuilder: currStep != (getSteps().length - 1)
                ? null
                : (BuildContext context,
                        {VoidCallback onStepContinue,
                        VoidCallback onStepCancel}) =>
                    Container(),
          ),
        ]),
      )),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.check),
          onPressed: () async {
              if(_formKey.currentState.validate()){
                Firestore.instance.collection('Patients').document(deviceIdController.text).setData({
                  'name': nameController.text,
                  'age': ageController.text,
                  'gender': genderController.text,
                  'room_no': roomNoController.text,
                  'device_id': deviceIdController.text,
                  'phone_no': phoneNoController.text,
                  'relative_contact': relativeContactController.text
                });
              } else {
                showAlert();
              }
          }),
    );
  }

}
