import 'dart:async';

import 'package:Vookad/config/location.dart';
import 'package:Vookad/models/searchAddr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hive/hive.dart';
import 'dart:convert';

class Header extends StatefulWidget {
  final Future<SearchAddr> fetchedloco;
  const Header({super.key, required this.fetchedloco});

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {

  FirebaseAuth auth = FirebaseAuth.instance;
  String? photoUrl;
  late StreamSubscription<User?> listener;

  @override
  void initState(){
    super.initState();
    photoUrl = auth.currentUser?.photoURL;
    listener = auth
      .userChanges()
      .listen((User? user) {
        if (user != null) {
          setState(() {
            photoUrl = auth.currentUser?.photoURL;
          });
        }
      });
  }

  @override
  void dispose(){
    super.dispose();
    listener.cancel();
  }

  @override
  Widget build(BuildContext context) {

    return Row(
            children: <Widget>[
              Expanded(
                flex:8,
                child: GestureDetector(
                  onTap: (){context.push('/address');},
                  child: SizedBox(
                  height: 60,
                  child:Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 5.0),
                  child: FutureBuilder(
                    future: widget.fetchedloco,
                    builder: (context,snapshot){
                      if(snapshot.hasData){
                        SearchAddr? addr = snapshot.data;
                        return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:<Widget>[
                        Row(
                          children: <Widget>[
                            SvgPicture.asset(
                              "assets/Map.svg",
                              width: 30, // Adjust the width of the SVG image
                              height: 30, // Adjust the height of the SVG image
                            ),
                            const SizedBox(width: 8),
                            Expanded(child: Text(
                              addr?.place ?? "",
                              style: const TextStyle(fontSize: 18,fontWeight: FontWeight.w600,),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            )),
                            const SizedBox(width: 8),
                            const Icon(Icons.keyboard_arrow_down),
                          ],
                        ),
                        // const SizedBox(height: 8), // Add spacing between the two rows
                        Text(
                          addr?.placeName ?? "",
                          style: const TextStyle(fontSize: 16),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ],);
                      }
                      return const SizedBox(
                        width: 50,
                      );
                    },
                  ),
                    ),
                ),
                ),
                ),
              // Expanded(
              //   flex:3,
              //   child: GestureDetector(
              //         // onTap: _toggle,
              //         child: AnimatedOpacity(
              //           duration: const Duration(milliseconds: 200),
              //           opacity: 1.0,
              //           child: Container(
              //             height: 35,
              //             decoration: BoxDecoration(
              //               color: HexColor('#0CBC8B'), // Replace with your hex color code
              //               borderRadius: BorderRadius.circular(60.0), // Set the border radius
              //             ),
              //             child: Row(
              //               children: <Widget>[
              //                 Expanded(
              //                   flex: 1,
              //                   child: Padding(
              //                     padding: const EdgeInsets.all(2.0),
              //                     child:SvgPicture.asset(
              //                       "assets/grass.svg",
              //                       width: 25, // Adjust the width of the SVG image
              //                       height: 25, // Adjust the height of the SVG image
              //                     ),
              //                 )),
              //                 const Expanded(
              //                     flex: 1,
              //                     child: Text("Veg",))
              //               ],
              //             ),
              //         ),
              //         ),
              //       ),
              // ),
              // const SizedBox(width: 5),
              Expanded(
                  flex:2,
                  child: GestureDetector(
                    onTap: () {
                      context.push('/profile');
                    },
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      child: Center(
                      child: SizedBox(
                        height: 50,
                        child: ClipOval(
                          child: photoUrl!=null?Image.network(photoUrl??"", fit: BoxFit.cover,):Image.asset('assets/dummy/profile.png'),
                        ),
                      )
                    ),
                    ),
                ),
              )
            ],
          );
  }
}
