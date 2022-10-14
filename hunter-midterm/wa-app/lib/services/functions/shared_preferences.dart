import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper{
  final Future<SharedPreferences> _pref = SharedPreferences.getInstance();
  static late SharedPreferences prefs;
  initPreferences()async{
    prefs = await _pref;
  }
}