import 'package:shared_preferences/shared_preferences.dart';

class HelperFunction{
  static String sharedPreferenceEmail = "EmailId";
  static String sharedPreferenceTokenKey = "TokenKey";
  static String sharedPreferenceUserLoggedInKey = 'LOGGEDIN';
  static String sharedPreferenceLongitude = "longitude";
  static String sharedPreferenceLatitude = "latitude";
  static String sharedPreferenceUserName = "UserName";

  static Future saveEmailId(String email) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPreferenceEmail, email);
  }

  static Future saveToken(String token) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPreferenceTokenKey, token);
  }

  static Future getEmailId() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(sharedPreferenceEmail);
  }

  static Future getToken() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(sharedPreferenceTokenKey);
  }

  static Future<bool> saveuserLoggedInSharedPreference(bool isuserLoggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(sharedPreferenceUserLoggedInKey, isuserLoggedIn);
  }

  static Future<bool?> getuserLoggedInSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getBool(sharedPreferenceUserLoggedInKey);
  }

  static Future getUserName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(sharedPreferenceUserName);
  }

  static Future saveUserName(String name)async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPreferenceUserName, name);
  }

  static Future saveLongitude(String longitude) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPreferenceLongitude, longitude);
  }

  static Future getLongitude() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(sharedPreferenceLongitude);
  }

  static Future saveLatitude(String latitude) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPreferenceLatitude, latitude);
  }

  static Future getLatitude() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(sharedPreferenceLatitude);
  }
}