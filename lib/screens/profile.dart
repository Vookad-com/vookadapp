import 'dart:async';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:go_router/go_router.dart';
import '../config/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  FirebaseAuth auth = FirebaseAuth.instance;
  String dispName = "";
  String? photoUrl;
  String phone = "";
  @override
  void initState(){
    super.initState();
    dispName = auth.currentUser?.displayName ?? "Edit your Name";
    photoUrl = auth.currentUser?.photoURL;
    phone = auth.currentUser?.phoneNumber ?? "";
    auth
      .userChanges()
      .listen((User? user) {
        if (user != null) {
          setState(() {
            dispName = auth.currentUser?.displayName ?? "Edit your Name";
            photoUrl = auth.currentUser?.photoURL;
            phone = auth.currentUser?.phoneNumber ?? "";
          });
        }
      });
  }

  Future<void> _launchInBrowserView(Uri url) async {
    if (!await launchUrl(url, mode: LaunchMode.inAppBrowserView)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
            body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(children: [
                Row(children: [
                  InkWell(
                    onTap: () {
                      context.pop();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(5.0),
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.bgSecondary
                      ), // set the background color of the circle
                      child: const Icon(
                        Icons.keyboard_arrow_left_rounded,
                        color: Colors.black,
                        size: 45,
                        weight: 4,
                      ), // set the icon and its color
                    ),
                  )
                ]),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 36),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: AppColors.bgSecondary,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(children: [
                        Text(
                          dispName,
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          phone,
                          style: const TextStyle(fontSize: 14, color: Colors.black),
                        ),
                        const SizedBox(height: 16),
                        GestureDetector(
                          onTap: () => context.push("/profile/edit"),
                          child: const Text(
                          'Edit Account Info',
                          style: TextStyle(fontSize: 14, color: AppColors.bgPrimary, fontWeight: FontWeight.w600),
                        ),
                        ),
                      ]),
                       photoUrl != null ? ClipOval(
                          child: Container(
                            width: 80, // Adjust the size of your circular image
                            height: 80,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: Image.network(
                              photoUrl!, // Replace with your image URL
                              fit: BoxFit.cover,
                            ),
                          ),
                        ): const SizedBox(),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: AppColors.bgSecondary,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: AppColors.bgPrimary,
                        ),
                        child: const Text(
                          'Your Activity',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      InkWell(
                        onTap: () => context.push("/profile/orders"),
                        child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors
                                      .bgPrimary
                              ), // set the background color of the circle
                              child: const Icon(
                                Icons.list_alt_sharp,
                                color: Colors.black,
                                size: 14,
                                weight: 2,
                              ), // set the icon and its color
                            ),
                            const SizedBox(width: 24),
                            const Text('Your Orders',
                                style: TextStyle(fontSize: 16),
                            )
                          ],
                        ),
                      ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                        color: AppColors.bgPrimary,
                        width: 3),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          'More Settings',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      InkWell(
                        onTap: ()=>{_launchInBrowserView(Uri.parse('https://www.vookad.com/'))},
                        child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors
                                      .bgPrimary
                              ), // set the background color of the circle
                              child: const Icon(
                                Icons.mail_outline,
                                color: Colors.black,
                                size: 14,
                                weight: 2,
                              ), // set the icon and its color
                            ),
                            const SizedBox(width: 24),
                            const Text('About',
                                style: TextStyle(fontSize: 16),
                            )
                          ],
                        ),
                      ),
                      ),
                      const SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors
                                      .bgPrimary
                              ), // set the background color of the circle
                              child: const Icon(
                                Icons.mail_outline,
                                color: Colors.black,
                                size: 14,
                                weight: 2,
                              ), // set the icon and its color
                            ),
                            const SizedBox(width: 24),
                            const Text('Send Feedback',
                                style: TextStyle(fontSize: 16),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  width: MediaQuery.of(context).size.width*90,
                  child: InkWell(
                  onTap: () {
                    // authBox.clear();
                    auth.signOut();
                    context.go("/login");
                  },
                  child: const Text("Log out", style: TextStyle(color: Colors.grey, fontSize: 22, fontWeight: FontWeight.w600),),
                ),
                )
              ]),
            ),
          ),
            ),
          bottomNavigationBar: null,
    );
  }
}
