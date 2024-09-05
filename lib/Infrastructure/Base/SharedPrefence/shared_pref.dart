import 'package:celebrity_quiz/Infrastructure/Commons/Constant/export.dart';

class SharedPref {
  bool? value;
  bool? musicValues;
  int? index;
  int? drawScore;
  String? token;

  Future<bool> getBoolValuesSF(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    value = prefs.getBool(key) ?? true;

    return value!;
  }

  void setBoolToSF(String key,bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  void deleteDataSF(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

  Future<String> getStringValuesSF(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    token = prefs.getString(key)?? "";

    return token!;
  }

  addStringToSF(String key,String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  Future<int> getInt() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    index = prefs.getInt(StorageConstants.currentIndex)  ?? 0;

    return index!;
  }

  void setInt(int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(StorageConstants.currentIndex, value);
  }

}