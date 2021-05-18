import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_side/stateManagment/providers/authState.dart';

class SharePrefService {
  SharedPreferences prefs;
  addBoolToSp() async {
    prefs = await SharedPreferences.getInstance();
    prefs.setBool('boolValue', true);
  }

  getBoolSp(AuthState authState) async {

    prefs = await SharedPreferences.getInstance();
    bool boolValue = prefs.getBool('boolValue');
    //print('bool valur is ${boolValue}');
    authState.loggedUser = boolValue;

  }
   updateBoolSp() async {

    prefs = await SharedPreferences.getInstance();
    prefs.setBool('boolValue', false);
    

  }
}
