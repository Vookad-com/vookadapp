import 'package:flutter/material.dart';
import 'package:eatit/config/config.dart';
import 'package:go_router/go_router.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Padding(
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                    child: Column(children: [
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
                                .bgPrimary), // set the background color of the circle
                        child: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Colors.black,
                          size: 24,
                          weight: 2,
                        ), // set the icon and its color
                      ),
                    )
                  ]),
                  const SizedBox(height: 16),
                  Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 36),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        color: AppColors.bgPrimary,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Image(image: AppImages.biryani),
                          Column(children: const [
                            Text(
                              'Siddharth Das',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            SizedBox(height: 12),
                            Text(
                              '+91 98765 43210',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.black),
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Edit Account Info',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.black),
                            ),
                          ]),
                        ],
                      ))
                ])))));
  }
}
