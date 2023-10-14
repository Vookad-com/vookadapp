import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

import 'router.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  bool get initialState => false;


  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    hiveInit();
  }

  void hiveInit() async {
    final appDir = await getApplicationDocumentsDirectory();
    Hive.init(appDir.path);
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return MaterialApp.router(
      title: 'Vookad',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        fontFamily: GoogleFonts.poppins().fontFamily,
      ),
      routerConfig: router,
    );
  }
}
