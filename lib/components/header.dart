import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hexcolor/hexcolor.dart';

class Header extends StatefulWidget {
  const Header({super.key});

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {

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
                  child: Column(
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
                            const Text(
                              'Home',
                              style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,),
                            ),
                            const SizedBox(width: 8),
                            const Icon(Icons.keyboard_arrow_down),
                          ],
                        ),
                        // const SizedBox(height: 8), // Add spacing between the two rows
                        const Text(
                          'ShreeKehta Vihar',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],),
                    ),
                ),
                ),
                ),
              Expanded(
                flex:3,
                child: GestureDetector(
                      // onTap: _toggle,
                      child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 200),
                        opacity: 1.0,
                        child: Container(
                          height: 35,
                          decoration: BoxDecoration(
                            color: HexColor('#0CBC8B'), // Replace with your hex color code
                            borderRadius: BorderRadius.circular(60.0), // Set the border radius
                          ),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child:SvgPicture.asset(
                                    "assets/grass.svg",
                                    width: 25, // Adjust the width of the SVG image
                                    height: 25, // Adjust the height of the SVG image
                                  ),
                              )),
                              const Expanded(
                                  flex: 1,
                                  child: Text("Veg",))
                            ],
                          ),
                      ),
                      ),
                    ),
              ),
              // const SizedBox(width: 5),
              Expanded(
                  flex:2,
                  child: GestureDetector(
                    onTap: () {
                      context.push('/profile');
                    },
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(60.0), // Set the border radius
                      ),
                      child: Image.asset('assets/dummy/profile.png')
                    ),
                ),
              )
            ],
          );
  }
}
