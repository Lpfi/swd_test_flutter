import 'dart:developer' as developer;

class PersonalData {
  final int id;
  final String name;
  final String surname;
  final String email;
  final String address;
  final String province;
  final String telephonenumber;
  final String citizenID;
  final String citizenbackID;

  PersonalData({
    required this.id,
    required this.name,
    required this.surname,
    required this.email,
    required this.address,
    required this.province,
    required this.telephonenumber,
    required this.citizenID,
    required this.citizenbackID,
  });
}

class PersonalDataList {
  List<PersonalData> _personalDataList = [];

  void addPersonalData(PersonalData data) {
    _personalDataList.add(data);
  }

  void removePersonalData(int id) {
    _personalDataList.removeWhere((data) => data.id == id);
  }

  List<PersonalData> getPersonalDataByProvince(String country) {
    return _personalDataList.where((data) => data.province == country).toList();
  }

  List<PersonalData> getAllPersonalData() {
    return _personalDataList;
  }

  String getSelectedName(int index) {
    if (_personalDataList.length > index) {
      return _personalDataList[index].name;
    } else {
      return "";
    }
  }
}
