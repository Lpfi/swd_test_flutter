import 'package:flutter/material.dart';
import 'package:swd_test_05_05_23/Model/Person.dart';
import 'package:swd_test_05_05_23/Model/Provices.dart';

class PersonalDataListView extends StatefulWidget {
  final PersonalDataList personalDataList;

  PersonalDataListView({required this.personalDataList});

  @override
  _PersonalDataListViewState createState() => _PersonalDataListViewState();
}

class _PersonalDataListViewState extends State<PersonalDataListView> {
  final List<String> _dropdownItems = Provinces().getproviceslist();
  List<PersonalData> personalDataToShow = [];
  String? selectedProvince;
  @override
  void initState() {
    selectedProvince = "All";
    super.initState();
    updatePersonalDataList();
  }

  void updatePersonalDataList() {
    setState(() {
      if (selectedProvince == "All") {
        personalDataToShow = widget.personalDataList.getAllPersonalData();
      } else {
        personalDataToShow = widget.personalDataList.getPersonalDataByProvince(selectedProvince!);
      }
    });
  }

  removePersonalData(int id) {
    setState(() {
      widget.personalDataList.removePersonalData(id);
      updatePersonalDataList();
    });
  }

  whenDeleted(BuildContext context) {
    // set up the button
    Widget okbtn = TextButton(
      child: const Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

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
            "Deleted",
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
      actions: [
        okbtn,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert2;
      },
    );
  }

  showAlertDialog(int index, String name, String surname, String province) {
    Widget cancelButton = TextButton(
      child: const Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: const Text(
        "Delete",
        style: TextStyle(color: Colors.red),
      ),
      onPressed: () {
        removePersonalData(index);
        Navigator.of(context).pop();
        whenDeleted(context);
      },
    );

    AlertDialog alert = AlertDialog(
      icon: const Icon(
        Icons.delete_forever,
        color: Colors.red,
      ),
      title: const Text("Delete ?"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$name $surname",
            style: const TextStyle(fontSize: 18),
          ),
          Text(
            province,
            style: const TextStyle(fontSize: 16),
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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.only(left: 9, right: 9),
                child: DropdownButton<String>(
                  isExpanded: true,
                  hint: const Text('Select Province'),
                  value: selectedProvince,
                  onChanged: (newValue) {
                    setState(() {
                      selectedProvince = newValue!;
                      updatePersonalDataList();
                    });
                  },
                  items: _dropdownItems.map((item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(item),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.72,
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
                            padding: const EdgeInsets.all(8.0),
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
                                    foregroundColor: MaterialStateProperty.all<Color>(Colors.red),
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(18.0),
                                        side: const BorderSide(color: Colors.red)))),
                                onPressed: () => {
                                      showAlertDialog(personalDataToShow[index].id, personalDataToShow[index].name,
                                          personalDataToShow[index].surname, personalDataToShow[index].province)
                                    },
                                child: Text("Delete".toUpperCase(), style: const TextStyle(fontSize: 11))),
                          ),
                        ],
                      )),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
