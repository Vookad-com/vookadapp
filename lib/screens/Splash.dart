import 'package:flutter/material.dart';
import 'dart:async';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';


class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 1), () async{
      await Hive.openBox('auth');
      // ignore: use_build_context_synchronously
      context.go('/home');
    });

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