import 'package:Vookad/models/searchAddr.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:go_router/go_router.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hive/hive.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../graphql/graphql.dart';
import '../graphql/userquery.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool restart = false;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();


  }

  void Start(BuildContext context) async {
    // Timer(const Duration(seconds: 1), () async{
    //   await Hive.openBox('deliveryDate');
    //   await Hive.openBox<SearchAddr>('searchAddrBox');
    //
    //   // ignore: use_build_context_synchronously
    //   context.go('/home');
    // });
    Future.wait([
      Hive.openBox('deliveryDate'),
      Hive.openBox<SearchAddr>('searchAddrBox'),
      messaging(),
    ])
        .then((val)=>context.go('/home'));
    // ignore: use_build_context_synchronously
  }

    Future<bool> messaging() async {
    final messaging = FirebaseMessaging.instance;

    final settings = await messaging.requestPermission(
     alert: true,
     announcement: false,
     badge: true,
     carPlay: false,
     criticalAlert: false,
     provisional: false,
     sound: true,
    );

     // if (kDebugMode) {
     //   print('Permission granted: ${settings.authorizationStatus}');
     // }

     try {
         String? token = await messaging.getToken();
         if (kDebugMode) {
          print('Registration Token=$token');
        }
        var query = MutationOptions(document: gql(setFCM), variables: {"fcmToken" : token});
        final Future<QueryResult> result = client.mutate(query);
        result.then((result){
          if (result.hasException) {
            if (kDebugMode) {
              print(result.exception);
            }
            throw Exception('Graphql error');
          } else {
            if (kDebugMode) {
              print(result.data);
            }
          }
        });
      } catch(e){
        print(e);
      }


    return true;
  }

  @override
  Widget build(BuildContext context) {
    try{
     Start(context);
   }catch(e){
     if (kDebugMode) {
       print("bug app init!");
     }
   }
    return const Scaffold(
      backgroundColor: Color(0xFFFF5021),
      body: Center(
        child: Stack(
          children: [
            SizedBox(
                child: Image(
              image: AssetImage("assets/Logo.png"),
              height: 500,
              width: 300,
            )),
          ],
        ),
      ),
    );
  }
}