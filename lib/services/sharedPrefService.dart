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
    if (boolValue == null) {
      authState.loggedUser = false;
    }
    //print('bool valur is ${boolValue}');
    else {
      authState.loggedUser = boolValue;
    }

  }
   updateBoolSp() async {

    prefs = await SharedPreferences.getInstance();
    prefs.setBool('boolValue', false);
    

  }
  addCurrentuserIdToSf(String id) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setString('currentUserId', id);
  }

  logOutCurrentuserSf() async {
    prefs = await SharedPreferences.getInstance();
    prefs.setString('currentUserId', 'log out');
  }
  Future<String> getcurrentUserId() async {
    prefs = await SharedPreferences.getInstance();
    String Id = prefs.getString('currentUserId');
    return Id;
  }
}
