import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:provider/provider.dart';
import 'package:user_side/screens/bottomNavScreen.dart';
import 'package:user_side/screens/bottomNavViews/tasksView.dart';
import 'package:user_side/screens/loginScreen.dart';
import 'package:user_side/stateManagment/providers/chatProvider.dart';
import 'package:user_side/stateManagment/providers/tasksProvider.dart';
import 'package:user_side/utils/customColors.dart';
import 'package:user_side/widgets/loadingBar.dart';
import 'package:user_side/services/sharedPrefService.dart';
import 'package:user_side/stateManagment/providers/authState.dart';
import 'package:user_side/stateManagment/providers/phoneAuthProvider.dart';
import 'package:user_side/utils/sizing.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.data}");
}

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    'This channel is used for important notifications.', // description
    importance: Importance.high,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
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
      ChangeNotifierProvider<ChatProvider>(
        create: (BuildContext context) {
          return ChatProvider();
        },
      ),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AuthState authState;

  SharePrefService sharePrefService = SharePrefService();

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  FlutterLocalNotificationsPlugin fltNotification;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //////////////////////////////////////////////////////////
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;

      if (notification != null && android != null) {
        if (message.data['type'] == 'booking') {
          flutterLocalNotificationsPlugin.show(
              notification.hashCode,
              notification.title,
              notification.body,
              NotificationDetails(
                android: AndroidNotificationDetails(
                  channel.id,
                  channel.name,
                  channel.description,
                  color: Colors.blue,
                  playSound: true,
                  icon: '@mipmap/ic_launcher',
                ),
              ));
        }
      }
    });
    ////////////////////////////////////////////////////////
    ///
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

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

  void _handleMessage(RemoteMessage message) {
    if (message.data['screen'] == 'offers') {
      print("yes");
      Get.to(TasksView());
    }
  }
}
