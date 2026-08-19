

import 'package:shared_preferences/shared_preferences.dart';

class LocalDataSource{

  static SharedPreferences? _prefs;


  static Future<SharedPreferences?> initLocalDataSource()async{
    _prefs = await SharedPreferences.getInstance();
    return _prefs;
  }

  static Future<void> setString(String key,String value)async{
    await _prefs?.setString(key, value);
  }

  static Future<void> setBool(String key,bool value)async{
    await _prefs?.setBool(key,value);
  }

  static Future<bool> getBool(String key)async{
    return  _prefs?.getBool(key) ?? false;
  }

  static Future<String> getString(String key)async {
    return  _prefs?.getString(key) ?? "";
  }


  static final String _loginStatus = "login_status";

   Future<void> setLoginStatus(bool value)async{
    await setBool(_loginStatus, value);
  }

   Future<bool> getLoginStatus() async{
    return await getBool(_loginStatus) ;
  }

  static final String _userId = "user_id";

   Future<void> setUserId(String value)async{
    await setString(_userId, value);
  }

   Future<String> getUserId() async{
    return await getString(_userId);
  }





}