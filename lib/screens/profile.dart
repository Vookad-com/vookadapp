import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../config/colors.dart';

class Profile extends StatelessWidget {

  const Profile({super.key});

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
                      const Column(children: [
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
                          style: TextStyle(fontSize: 14, color: Colors.black),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Edit Account Info',
                          style: TextStyle(fontSize: 14, color: AppColors.bgPrimary, fontWeight: FontWeight.w600),
                        ),
                      ]),
                       ClipOval(
                          child: Container(
                            width: 80, // Adjust the size of your circular image
                            height: 80,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: Image.network(
                              'https://lh3.googleusercontent.com/u/0/drive-viewer/AK7aPaDm6ZAJMNEru5VaJppRftiLZbK5C7XeAimt0b6OPZWUJ-BJ3KKf9hhPTUr4ZDGZmWL-1mMx_efex-d79IrzPhSOmzZ1TA=w1909-h918', // Replace with your image URL
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
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
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.bgPrimary
                                    ), // set the background color of the circle
                              child: const Icon(
                                Icons.mail_outline,
                                color: Colors.black,
                                size: 14,
                                weight: 2,
                              ), // set the icon and its color
                            ),
                            const SizedBox(width: 24),
                            const Text('Active Subscription',
                                style: TextStyle(fontSize: 16),
                            )
                          ],
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
                            const Text('Your Orders',
                                style: TextStyle(fontSize: 16),
                            )
                          ],
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
                            const Text('Address book',
                                style: TextStyle(fontSize: 16),
                            )
                          ],
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
                            const Text('Your Rating',
                                style: TextStyle(fontSize: 16),
                            )
                          ],
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
                        // color: AppColors.bgPrimary
                        width: 5),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          // color: AppColors.bgSecondary,
                        ),
                        child: const Text(
                          'More Settings',
                          style: TextStyle(
                            fontSize: 16,
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
                            const Text('Choose Language',
                                style: TextStyle(fontSize: 16),
                            )
                          ],
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
                            const Text('About',
                                style: TextStyle(fontSize: 16),
                            )
                          ],
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
                )
              ]),
            ),
          ),
            ),
          bottomNavigationBar: null,
    );
  }
}

// Scaffold(
//             backgroundColor: Colors.black,
//             body: Padding(
//       padding: const EdgeInsets.all(20),
//       child: SingleChildScrollView(
//         child: Column(children: [
//           Row(children: [
//             InkWell(
//               onTap: () {
//                 // context.pop();
//               },
//               child: Container(
//                 padding: const EdgeInsets.only(
//                     top: 12, right: 14, bottom: 12, left: 12),
//                 decoration: const BoxDecoration(
//                     shape: BoxShape.circle,
//                     // color: AppColors.bgPrimary
//                 ), // set the background color of the circle
//                 child: const Icon(
//                   Icons.arrow_back_ios_new_rounded,
//                   color: Colors.black,
//                   size: 24,
//                   weight: 2,
//                 ), // set the icon and its color
//               ),
//             )
//           ]),
//           const SizedBox(height: 16),
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 36),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(24),
//               // color: AppColors.bgPrimary,
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Column(children: [
//                   Text(
//                     'Siddharth Das',
//                     style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black),
//                   ),
//                   SizedBox(height: 12),
//                   Text(
//                     '+91 98765 43210',
//                     style: TextStyle(fontSize: 14, color: Colors.black),
//                   ),
//                   SizedBox(height: 16),
//                   Text(
//                     'Edit Account Info',
//                     style: TextStyle(fontSize: 14, color: Colors.black),
//                   ),
//                 ]),
//                 // const Image(image: AppImages.avatar)
//               ],
//             ),
//           ),
//           const SizedBox(height: 16),
//           Container(
//             padding: const EdgeInsets.all(16),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(24),
//               // border: Border.all(color: AppColors.bgPrimary, width: 5),
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Container(
//                   padding: const EdgeInsets.all(12),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(8),
//                     // color: AppColors.bgSecondary,
//                   ),
//                   child: const Text(
//                     'Your Activity',
//                     style: TextStyle(
//                       fontSize: 16,
//
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 12),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Row(
//                     children: [
//                       Container(
//                         padding: const EdgeInsets.all(8),
//                         decoration: const BoxDecoration(
//                             shape: BoxShape.circle,
//                             // color: AppColors
//                             //     .bgSecondary
//                               ), // set the background color of the circle
//                         child: const Icon(
//                           Icons.mail_outline,
//                           color: Colors.black,
//                           size: 14,
//                           weight: 2,
//                         ), // set the icon and its color
//                       ),
//                       const SizedBox(width: 24),
//                       const Text('Active Subscription',
//                           style: TextStyle(fontSize: 16),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 12),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Row(
//                     children: [
//                       Container(
//                         padding: const EdgeInsets.all(8),
//                         decoration: const BoxDecoration(
//                             shape: BoxShape.circle,
//                             // color: AppColors
//                             //     .bgSecondary
//                         ), // set the background color of the circle
//                         child: const Icon(
//                           Icons.mail_outline,
//                           color: Colors.black,
//                           size: 14,
//                           weight: 2,
//                         ), // set the icon and its color
//                       ),
//                       const SizedBox(width: 24),
//                       const Text('Your Orders',
//                           style: TextStyle(fontSize: 16),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 12),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Row(
//                     children: [
//                       Container(
//                         padding: const EdgeInsets.all(8),
//                         decoration: const BoxDecoration(
//                             shape: BoxShape.circle,
//                             // color: AppColors
//                             //     .bgSecondary
//                         ), // set the background color of the circle
//                         child: const Icon(
//                           Icons.mail_outline,
//                           color: Colors.black,
//                           size: 14,
//                           weight: 2,
//                         ), // set the icon and its color
//                       ),
//                       const SizedBox(width: 24),
//                       const Text('Address book',
//                           style: TextStyle(fontSize: 16),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 12),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Row(
//                     children: [
//                       Container(
//                         padding: const EdgeInsets.all(8),
//                         decoration: const BoxDecoration(
//                             shape: BoxShape.circle,
//                             // color: AppColors
//                             //     .bgSecondary
//                         ), // set the background color of the circle
//                         child: const Icon(
//                           Icons.mail_outline,
//                           color: Colors.black,
//                           size: 14,
//                           weight: 2,
//                         ), // set the icon and its color
//                       ),
//                       const SizedBox(width: 24),
//                       const Text('Your Rating',
//                           style: TextStyle(fontSize: 16),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(height: 16),
//           Container(
//             padding: const EdgeInsets.all(16),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(24),
//               border: Border.all(
//                   // color: AppColors.bgPrimary
//                   width: 5),
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Container(
//                   padding: const EdgeInsets.all(12),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(8),
//                     // color: AppColors.bgSecondary,
//                   ),
//                   child: const Text(
//                     'More Settings',
//                     style: TextStyle(
//                       fontSize: 16,
//
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 12),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Row(
//                     children: [
//                       Container(
//                         padding: const EdgeInsets.all(8),
//                         decoration: const BoxDecoration(
//                             shape: BoxShape.circle,
//                             // color: AppColors
//                             //     .bgSecondary
//                         ), // set the background color of the circle
//                         child: const Icon(
//                           Icons.mail_outline,
//                           color: Colors.black,
//                           size: 14,
//                           weight: 2,
//                         ), // set the icon and its color
//                       ),
//                       const SizedBox(width: 24),
//                       const Text('Choose Language',
//                           style: TextStyle(fontSize: 16),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 12),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Row(
//                     children: [
//                       Container(
//                         padding: const EdgeInsets.all(8),
//                         decoration: const BoxDecoration(
//                             shape: BoxShape.circle,
//                             // color: AppColors
//                             //     .bgSecondary
//                         ), // set the background color of the circle
//                         child: const Icon(
//                           Icons.mail_outline,
//                           color: Colors.black,
//                           size: 14,
//                           weight: 2,
//                         ), // set the icon and its color
//                       ),
//                       const SizedBox(width: 24),
//                       const Text('About',
//                           style: TextStyle(fontSize: 16),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 12),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Row(
//                     children: [
//                       Container(
//                         padding: const EdgeInsets.all(8),
//                         decoration: const BoxDecoration(
//                             shape: BoxShape.circle,
//                             // color: AppColors
//                             //     .bgSecondary
//                         ), // set the background color of the circle
//                         child: const Icon(
//                           Icons.mail_outline,
//                           color: Colors.black,
//                           size: 14,
//                           weight: 2,
//                         ), // set the icon and its color
//                       ),
//                       const SizedBox(width: 24),
//                       const Text('Send Feedback',
//                           style: TextStyle(fontSize: 16),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           )
//         ]),
//       ),
//     ))