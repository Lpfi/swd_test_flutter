import 'package:flutter/material.dart';
import 'package:swd_test_05_05_23/Model/Person.dart';
import 'package:swd_test_05_05_23/Pages/addpersoninfo.dart';
import 'package:swd_test_05_05_23/Pages/showlist.dart';
import 'package:swd_test_05_05_23/Pages/showpersoninfo.dart';

class Tabs extends StatelessWidget {
  final PersonalDataList personalDataList = PersonalDataList();

  Tabs({super.key});
  static PersonalData simple_data = PersonalData(
      id: 0,
      name: "Wisawa",
      surname: "Chaithaset",
      email: "wisawa.chaithasett@gmail.com",
      address: "22/123 abc",
      province: "Bangkok",
      telephonenumber: "098123456",
      citizenID: "1101233422568",
      citizenbackID: "AB145768532598");

  List<String> pages = ["Contracts List", "", ""];

  @override
  Widget build(BuildContext context) {
    personalDataList.addPersonalData(simple_data);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
          backgroundColor: const Color.fromARGB(209, 29, 6, 45),
          appBar: AppBar(
            title: const Text("SWD - TEST FLUTTER "),
            backgroundColor: const Color.fromARGB(209, 44, 4, 73),
          ),
          body: Column(
            children: [
              const TabBar(
                tabs: [
                  Tab(
                    icon: Icon(Icons.list_alt_rounded),
                  ),
                  Tab(
                    icon: Icon(Icons.person_add),
                  ),
                  Tab(
                    icon: Icon(Icons.person),
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    PersonalDataListView(personalDataList: personalDataList),
                    AddPersonInfo(
                      personalDataList: personalDataList,
                    ),
                    ShowPersonInfo(
                      personalDataList: personalDataList,
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
