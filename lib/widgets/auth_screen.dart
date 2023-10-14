import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../config/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key, required this.children});
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(children: [
                    InkWell(
                      onTap: () {
                        context.pop();
                      },
                      child: Container(
                        padding: const EdgeInsets.only(
                            top: 12, right: 14, bottom: 12, left: 12),
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors
                                .yellow), // set the background color of the circle
                        child: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Colors.black,
                          size: 24,
                          weight: 2,
                        ), // set the icon and its color
                      ),
                    )
                  ]),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40),
                    child: SvgPicture.asset(
                              "assets/authorize.svg",
                              height: 220, // Adjust the height of the SVG image
                            ),
                  ),
                  Column(children: children),
                ],
              ),
            )),
      ),
    );
  }
}
