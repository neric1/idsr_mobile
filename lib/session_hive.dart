import 'package:hive/hive.dart';

const String keyUsername = 'keyUsername';

const String keyPassword="keyPassword";

class Session {
  Session._();

  static var sems = Hive.box('semsBox');


  ///Save Token
  static saveUsername(value) {
    sems.put(keyUsername, value);
  }

  static String getUsername() {
    return sems.get(keyUsername) ?? "";
  }

  static deleteUsername() {
    sems.delete(keyUsername);
  }

  ///Save Refresh Token
  static savePassword(value) {
    sems.put(keyPassword, value);
  }

  static String getPassword() {
    return sems.get(keyPassword) ?? "";
  }

  static deletePassword() {
    sems.delete(keyPassword);
  }
  static bool get isLoggedIn => getUsername().isNotEmpty && getPassword().isNotEmpty;
  static void logout() {
    deleteUsername();
    deletePassword();
  }




}