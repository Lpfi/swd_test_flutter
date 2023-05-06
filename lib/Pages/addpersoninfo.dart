import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:swd_test_05_05_23/Model/Person.dart';
import 'package:swd_test_05_05_23/Model/Provices.dart';
import 'dart:developer' as developer;

class AddPersonInfo extends StatefulWidget {
  final PersonalDataList personalDataList;
  const AddPersonInfo({super.key, required this.personalDataList});

  @override
  State<AddPersonInfo> createState() => _AddPersonInfoState();
}

class _AddPersonInfoState extends State<AddPersonInfo> {
  List<PersonalData> personalDataToAdd = [];
  final List<String> _dropdownItems = Provinces().getproviceslistnoall();
  final name = TextEditingController();
  final surname = TextEditingController();
  final email = TextEditingController();
  final address = TextEditingController();
  String province = "Bangkok";
  final telephonenumber = TextEditingController();
  final citizenID = TextEditingController();
  final citizenbackID = TextEditingController();
  int _index = 0;
  final Color fontcolor = Colors.black;
  bool isCompleteAllStep = false;

  @override
  void initState() {
    super.initState();
    updatePersonalDataList();
  }

  void updatePersonalDataList() {
    setState(() {
      personalDataToAdd = widget.personalDataList.getAllPersonalData();
    });
  }

  List<Step> getSteps() => [
        Step(
          state: _index > 0 ? StepState.complete : StepState.indexed,
          isActive: _index >= 0,
          title: Text(
            'Step 1 Enter your Personal Details.',
            style: TextStyle(color: fontcolor),
          ),
          content: Form(
            autovalidateMode: AutovalidateMode.always,
            child: Column(
              children: <Widget>[
                TextFormField(
                  validator: (value) => value!.isNotEmpty ? null : "Please enter a FirstName",
                  controller: name,
                  decoration: const InputDecoration(labelText: "FirstName"),
                ),
                TextFormField(
                  validator: (value) => value!.isNotEmpty ? null : "Please enter a LastName",
                  controller: surname,
                  decoration: const InputDecoration(labelText: "LastName"),
                ),
                TextFormField(
                  controller: email,
                  decoration: const InputDecoration(labelText: "Email"),
                  validator: (value) => EmailValidator.validate(value!) ? null : "Please enter a valid email",
                  keyboardType: TextInputType.emailAddress,
                ),
                TextFormField(
                  validator: (value) => value!.isNotEmpty ? null : "Please enter a address",
                  controller: address,
                  decoration: const InputDecoration(labelText: "address"),
                  keyboardType: TextInputType.streetAddress,
                ),
                DropdownButton<String>(
                  isExpanded: true,
                  hint: const Text('Select Province'),
                  value: province,
                  onChanged: (newValue) {
                    setState(() {
                      province = newValue!;
                    });
                  },
                  items: _dropdownItems.map((item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(item),
                    );
                  }).toList(),
                ),
                TextFormField(
                  validator: (value) => value!.isNotEmpty && value.length == 10 ? null : "Please enter a Phone Number",
                  controller: telephonenumber,
                  decoration: const InputDecoration(labelText: "Phone Number"),
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          ),
        ),
        Step(
          state: _index > 1 ? StepState.complete : StepState.indexed,
          isActive: _index >= 1,
          title: Text(
            'Step 2 Enter you Citizen ID',
            style: TextStyle(color: fontcolor),
          ),
          content: Form(
            autovalidateMode: AutovalidateMode.always,
            child: Column(
              children: <Widget>[
                TextFormField(
                  validator: (value) => value!.isNotEmpty && value.length == 13 ? null : "Please enter your Citizen ID",
                  controller: citizenID,
                  decoration: const InputDecoration(labelText: "Citizen ID"),
                  keyboardType: TextInputType.number,
                ),
                TextFormField(
                  validator: (value) =>
                      value!.isNotEmpty && value.length == 12 ? null : "Please enter your ID-Card Backcode",
                  controller: citizenbackID,
                  decoration: const InputDecoration(labelText: "ID-Card Backcode"),
                  keyboardType: TextInputType.text,
                ),
              ],
            ),
          ),
        ),
        Step(
          isActive: _index >= 2,
          title: Text(
            'Step 3 Completed ',
            style: TextStyle(color: fontcolor),
          ),
          content: Text(
            'Please double-check the data before clicking on the "Save" button.',
            style: TextStyle(color: fontcolor),
          ),
        ),
      ];
  resetform() {
    setState(() {
      isCompleteAllStep = false;
      _index = 0;
      name.clear();
      surname.clear();
      email.clear();
      province = "Bangkok";
      address.clear();
      telephonenumber.clear();
      citizenID.clear();
      citizenbackID.clear();
    });
  }

  showAlertDialog(PersonalData datasend) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: const Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: const Text(
        "Save",
        style: TextStyle(color: Colors.green),
      ),
      onPressed: () {
        setState(() {
          widget.personalDataList.addPersonalData(datasend);
          resetform();
          Navigator.of(context).pop();
          whenDeleted(context);
        });
      },
    );

    AlertDialog alert = AlertDialog(
      icon: const Icon(
        Icons.save_alt_rounded,
        color: Colors.green,
      ),
      title: const Text("Save"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            "Are you sure?",
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  whenDeleted(BuildContext context) {
    // set up the button
    Widget okbtn = TextButton(
      child: const Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert2 = AlertDialog(
      icon: const Icon(
        Icons.check,
        color: Colors.green,
      ),
      title: const Text("Done !"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            "Saved",
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
      actions: [
        okbtn,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert2;
      },
    );
  }

  savedata() {
    if (name.toString().isNotEmpty &&
        surname.toString().isNotEmpty &&
        email.toString().isNotEmpty &&
        address.toString().isNotEmpty &&
        telephonenumber.toString().isNotEmpty &&
        citizenID.toString().isNotEmpty &&
        citizenbackID.toString().isNotEmpty) {
      PersonalData datasend = PersonalData(
          id: personalDataToAdd.length ,
          name: name.text,
          surname: surname.text,
          email: email.text,
          address: address.text,
          province: province,
          telephonenumber: telephonenumber.text,
          citizenID: citizenID.text,
          citizenbackID: citizenbackID.text);

      showAlertDialog(datasend);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(209, 29, 6, 45),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.78,
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(30)),
          child: Theme(
            data: Theme.of(context)
                .copyWith(colorScheme: const ColorScheme.light(primary: Color.fromARGB(255, 95, 33, 129))),
            child: Stepper(
              onStepTapped: (step) => setState(() => _index = step),
              currentStep: _index,
              onStepContinue: () {
                final getfinalstep = _index == getSteps().length - 1;
                if (getfinalstep) {
                  setState(() {
                    isCompleteAllStep = true;
                    savedata();
                  });
                } else {
                  setState(() {
                    _index += 1;
                  });
                }
              },
              onStepCancel: () {
                if (_index == 0) {
                  Null;
                } else {
                  setState(() {
                    _index -= 1;
                  });
                }
              },
              controlsBuilder: (BuildContext context, ControlsDetails controlsDetails) {
                final getfinalstep = _index == getSteps().length - 1;

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      if (_index != 0) ...[
                        Expanded(
                          child: ElevatedButton(
                            onPressed: controlsDetails.onStepCancel,
                            child: const Text("Back Step"),
                          ),
                        ),
                      ],
                      const SizedBox(width: 15),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: controlsDetails.onStepContinue,
                          child: Text(getfinalstep ? "Save" : "Next Step"),
                        ),
                      ),
                    ],
                  ),
                );
              },
              steps: getSteps(),
            ),
          ),
        ),
      ),
    );
  }
}
