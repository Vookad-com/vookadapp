import 'dart:async';

import 'package:Vookad/config/colors.dart';
import 'package:Vookad/models/product.dart';
import 'package:Vookad/models/searchAddr.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'firebase_options.dart';

import 'router.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rxdart/rxdart.dart';


Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
   await Firebase.initializeApp();

   if (kDebugMode) {
     print("Handling a background message: ${message.messageId}");
     print('Message data: ${message.data}');
     print('Message notification: ${message.notification?.title}');
     print('Message notification: ${message.notification?.body}');
   }
  }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
  final appDir = await getApplicationDocumentsDirectory();
  Hive.init(appDir.path);
  if (!Hive.isAdapterRegistered(ProductAdapter().typeId)) {
    Hive.registerAdapter(ProductAdapter());
  }if (!Hive.isAdapterRegistered(SearchAddrAdapter().typeId)) {
    Hive.registerAdapter(SearchAddrAdapter());
  }
  runApp(const MyApp());
}
final _messageStreamController = BehaviorSubject<RemoteMessage>();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void hiveInit() async {

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    var fireAppcheck =  FirebaseAppCheck.instance.activate(
      webProvider: ReCaptchaV3Provider('recaptcha-v3-site-key'),
      // androidProvider: AndroidProvider.debug,
      androidProvider: AndroidProvider.playIntegrity,
      appleProvider: AppleProvider.appAttest,
    );
    fireAppcheck.then(
            (val) async {
                if (kDebugMode) {
                  print("initialized");
                }
                FirebaseMessaging.onMessage.listen((RemoteMessage message) {
                  if (kDebugMode) {
                    print('Message notification: ${message.notification?.title}');
                    print('Message notification: ${message.notification?.body}');
                  }

                  _messageStreamController.sink.add(message);
                });
                setState(() {

                });
              });
  }

  @override
  void initState(){
    super.initState();
    hiveInit();
  }
  @override
  Widget build(BuildContext context) {

   //  _messageStreamController.listen((message) {
   //   if (message.notification != null) {
   //       if (kDebugMode) {
   //         print('Received a notification message:'
   //           '\nTitle=${message.notification?.title},'
   //           '\nBody=${message.notification?.body},'
   //           '\nData=${message.data}');
   //       }
   //     } else {
   //       if (kDebugMode) {
   //         print('Received a data message: ${message.data}');
   //       }
   //     }
   // });
    return MaterialApp.router(
      title: 'Vookad',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        primaryColor: AppColors.bgPrimary,
        fontFamily: GoogleFonts.poppins().fontFamily,
        unselectedWidgetColor: AppColors.bgPrimary,
        radioTheme: RadioThemeData(fillColor: MaterialStateColor.resolveWith((states) => AppColors.bgPrimary))
      ),
      routerConfig: router,
    );
  }
}

