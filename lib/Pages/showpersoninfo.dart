import 'package:flutter/material.dart';
import 'package:swd_test_05_05_23/Model/Person.dart';

class ShowPersonInfo extends StatefulWidget {
  const ShowPersonInfo({super.key, required this.personalDataList});
  final PersonalDataList personalDataList;
  @override
  State<ShowPersonInfo> createState() => _ShowPersonInfoState();
}

class _ShowPersonInfoState extends State<ShowPersonInfo> {
  List<PersonalData> personalDataToShow = [];

  @override
  void initState() {
    super.initState();
    updatePersonalDataList();
  }

  void updatePersonalDataList() {
    setState(() {
      personalDataToShow = widget.personalDataList.getAllPersonalData();
    });
  }

  showDetail(BuildContext context, int id) {
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
        Icons.info,
        color: Colors.green,
      ),
      title: Text("${personalDataToShow[id].name} ${personalDataToShow[id].surname}"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "E-mail: ${personalDataToShow[id].email}",
            style: const TextStyle(fontSize: 16),
          ),
          Text(
            "Address: ${personalDataToShow[id].address}",
            style: const TextStyle(fontSize: 16),
          ),
          Text(
            "Province: ${personalDataToShow[id].province}",
            style: const TextStyle(fontSize: 16),
          ),
          Text(
            "Number: ${personalDataToShow[id].telephonenumber}",
            style: const TextStyle(fontSize: 16),
          ),
          Text(
            "Citizen ID: ${personalDataToShow[id].citizenID}",
            style: const TextStyle(fontSize: 16),
          ),
          Text(
            "Back-Code: ${personalDataToShow[id].citizenbackID}",
            style: const TextStyle(fontSize: 16),
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

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(209, 29, 6, 45),
      body: SizedBox(
        height: MediaQuery.of(context).size.height * 0.8,
        child: ListView.builder(
          itemCount: personalDataToShow.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.1,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${index + 1}. ${"${personalDataToShow[index].name} ${personalDataToShow[index].surname}"} ",
                                style: const TextStyle(fontSize: 18),
                                overflow: TextOverflow.fade,
                                maxLines: 1,
                                softWrap: false,
                              ),
                              Text(
                                personalDataToShow[index].province,
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextButton(
                            style: ButtonStyle(
                                padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(10)),
                                foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: const BorderSide(color: Color.fromARGB(255, 22, 80, 127))))),
                            onPressed: () => {showDetail(context, index)},
                            child: Text("Detail".toUpperCase(), style: const TextStyle(fontSize: 11))),
                      ),
                    ],
                  )),
            );
          },
        ),
      ),
    );
  }
}
