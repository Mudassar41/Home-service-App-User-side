import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:provider/provider.dart';
import 'package:user_side/screens/bottomNavScreen.dart';
import 'package:user_side/screens/loginScreen.dart';
import 'package:user_side/stateManagment/providers/tasksProvider.dart';
import 'package:user_side/utils/customColors.dart';
import 'package:user_side/widgets/loadingBar.dart';
import 'package:user_side/services/sharedPrefService.dart';
import 'package:user_side/stateManagment/providers/authState.dart';
import 'package:user_side/stateManagment/providers/phoneAuthProvider.dart';
import 'package:user_side/utils/sizing.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarIconBrightness: Brightness.light,
    statusBarColor: CustomColors.lightGreen, // status bar color
  ));
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<PhoneAuthProvidr>(
        create: (BuildContext context) {
          return PhoneAuthProvidr();
        },
      ),
      ChangeNotifierProvider<TasksProvider>(
        create: (BuildContext context) {
          return TasksProvider();
        },
      ),
      ChangeNotifierProvider<AuthState>(
        create: (BuildContext context) {
          return AuthState();
        },
      ),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  AuthState authState;
  SharePrefService sharePrefService = SharePrefService();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    authState = Provider.of<AuthState>(context);
    sharePrefService.getBoolSp(authState);
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(builder: (context, orientaion) {
          Sizing().init(constraints, orientaion);
          return GetMaterialApp(
              theme: ThemeData(
                  fontFamily: 'Candal',
                  primaryColor: Colors.white,
                  primaryIconTheme: IconThemeData(color: Colors.black45)),
              debugShowCheckedModeBanner: false,
              title: 'Providerlance',
              home: authState.loggedUser == null
                  ? LoadingBar()
                  : authState.loggedUser == true
                      ? NavScreen()
                      : LoginScreen());
        });
      },
    );
  }
}
