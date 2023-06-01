import 'package:eatit/screens/lib/movie_model.dart';
import 'package:flutter/material.dart';
import 'package:eatit/config/config.dart';
import 'package:go_router/go_router.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/gestures.dart';

class Home1 extends StatelessWidget {
  const Home1({super.key});

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
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 36),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: AppColors.bgPrimary,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
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
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Edit Account Info',
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                ]),
                const Image(image: AppImages.avatar)
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: AppColors.bgPrimary, width: 5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppColors.bgSecondary,
                  ),
                  child: const Text(
                    'Your Activity',
                    style: TextStyle(
                      fontSize: 16,
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
                            color: AppColors
                                .bgSecondary), // set the background color of the circle
                        child: const Icon(
                          Icons.mail_outline,
                          color: Colors.black,
                          size: 14,
                          weight: 2,
                        ), // set the icon and its color
                      ),
                      const SizedBox(width: 24),
                      const Text('Active Subscription',
                          style: TextStyle(fontSize: 16, color: Colors.white)),
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
                                .bgSecondary), // set the background color of the circle
                        child: const Icon(
                          Icons.mail_outline,
                          color: Colors.black,
                          size: 14,
                          weight: 2,
                        ), // set the icon and its color
                      ),
                      const SizedBox(width: 24),
                      const Text('Your Orders',
                          style: TextStyle(fontSize: 16, color: Colors.white)),
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
                                .bgSecondary), // set the background color of the circle
                        child: const Icon(
                          Icons.mail_outline,
                          color: Colors.black,
                          size: 14,
                          weight: 2,
                        ), // set the icon and its color
                      ),
                      const SizedBox(width: 24),
                      const Text('Address book',
                          style: TextStyle(fontSize: 16, color: Colors.white)),
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
                                .bgSecondary), // set the background color of the circle
                        child: const Icon(
                          Icons.mail_outline,
                          color: Colors.black,
                          size: 14,
                          weight: 2,
                        ), // set the icon and its color
                      ),
                      const SizedBox(width: 24),
                      const Text('Your Rating',
                          style: TextStyle(fontSize: 16, color: Colors.white)),
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
              border: Border.all(color: AppColors.bgPrimary, width: 5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppColors.bgSecondary,
                  ),
                  child: const Text(
                    'More Settings',
                    style: TextStyle(
                      fontSize: 16,
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
                            color: AppColors
                                .bgSecondary), // set the background color of the circle
                        child: const Icon(
                          Icons.mail_outline,
                          color: Colors.black,
                          size: 14,
                          weight: 2,
                        ), // set the icon and its color
                      ),
                      const SizedBox(width: 24),
                      const Text('Choose Language',
                          style: TextStyle(fontSize: 16, color: Colors.white)),
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
                                .bgSecondary), // set the background color of the circle
                        child: const Icon(
                          Icons.mail_outline,
                          color: Colors.black,
                          size: 14,
                          weight: 2,
                        ), // set the icon and its color
                      ),
                      const SizedBox(width: 24),
                      const Text('About',
                          style: TextStyle(fontSize: 16, color: Colors.white)),
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
                                .bgSecondary), // set the background color of the circle
                        child: const Icon(
                          Icons.mail_outline,
                          color: Colors.black,
                          size: 14,
                          weight: 2,
                        ), // set the icon and its color
                      ),
                      const SizedBox(width: 24),
                      const Text('Send Feedback',
                          style: TextStyle(fontSize: 16, color: Colors.white)),
                    ],
                  ),
                ),
              ],
            ),
          )
        ]),
      ),
    )));
  }
}

// import 'package:flutter/material.dart';
// import 'package:eatit/config/config.dart';
// import 'package:go_router/go_router.dart';

// class Home extends StatelessWidget {
//   const Home({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: Scaffold(
//             body: Padding(
//                 padding: const EdgeInsets.all(20),
//                 child: SingleChildScrollView(
//                     child: Column(children: [
//                   Row(children: [
//                     InkWell(
//                       onTap: () {
//                         context.pop();
//                       },
//                       child: Container(
//                         padding: const EdgeInsets.only(
//                             top: 12, right: 14, bottom: 12, left: 12),
//                         decoration: const BoxDecoration(
//                             shape: BoxShape.circle,
//                             color: AppColors
//                                 .bgPrimary), // set the background color of the circle
//                         child: const Icon(
//                           Icons.arrow_back_ios_new_rounded,
//                           color: Colors.black,
//                           size: 24,
//                           weight: 2,
//                         ), // set the icon and its color
//                       ),
//                     )
//                   ]),
//                   const SizedBox(height: 16),
//                   Container(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 10, vertical: 1),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(24),
//                         color: Color.fromARGB(255, 57, 57, 56),
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           const Image(
//                             image: AppImages.biryani,
//                             height: 160,
//                             width: 120,
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 30),
//                             child: Column(children: [
//                               Text(
//                                 'Chicken Biryani',
//                                 style: TextStyle(
//                                     fontSize: 20,
//                                     fontWeight: FontWeight.bold,
//                                     color: Color.fromARGB(255, 237, 232, 232)),
//                               ),
//                               SizedBox(height: 12),
//                               Text(
//                                 'Lorem Ipsum',
//                                 style: TextStyle(
//                                     fontSize: 14,
//                                     color: Color.fromARGB(255, 237, 232, 232)),
//                               ),
//                               SizedBox(height: 10),
//                               Padding(
//                                 padding: EdgeInsets.only(top: 0),
//                                 child: Row(
//                                   children: [
//                                     Text(
//                                       'Rs 110',
//                                       style: TextStyle(
//                                           fontSize: 24,
//                                           fontWeight: FontWeight.w600,
//                                           color: Color.fromARGB(
//                                               255, 208, 211, 21)),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               Padding(
//                                 padding: EdgeInsets.only(top: 15),
//                                 child: Align(
//                                   alignment: Alignment.bottomRight,
//                                   child: Icon(
//                                     Icons.shopping_cart,
//                                     size: 28,
//                                     color: Colors.pink.shade300,
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(height: 16),
//                             ]),
//                           ),
//                         ],
//                       ))
//                 ])))));
//   }
// }

//Menu Page
// import 'package:flutter/material.dart';
// import 'package:eatit/config/config.dart';
// import 'package:go_router/go_router.dart';

// class Home extends StatelessWidget {
//   const Home({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: Scaffold(
//             body: Container(
//                 child: SingleChildScrollView(
//                     child: Column(children: [
//       Row(children: [
//         InkWell(
//           onTap: () {
//             context.pop();
//           },
//           child: Container(
//             padding:
//                 const EdgeInsets.only(top: 12, right: 14, bottom: 12, left: 12),
//             decoration: const BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: AppColors
//                     .bgPrimary), // set the background color of the circle
//             child: const Icon(
//               Icons.arrow_back_ios_new_rounded,
//               color: Colors.black,
//               size: 24,
//               weight: 2,
//             ), // set the icon and its color
//           ),
//         )
//       ]),
//       const SizedBox(height: 20),
//       Container(
//           padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(24),
//             color: Color.fromARGB(255, 57, 57, 56),
//           ),
//           child: Row(
//             children: [
//               const Image(
//                 image: AppImages.biryani,
//                 height: 160.2,
//                 width: 120,
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 30),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Chicken Biryani',
//                       style: TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                           color: Color.fromARGB(255, 237, 232, 232)),
//                     ),
//                     SizedBox(height: 12),
//                     Text(
//                       'Lorem Ipsum',
//                       style: TextStyle(
//                           fontSize: 14,
//                           color: Color.fromARGB(255, 237, 232, 232)),
//                     ),
//                     SizedBox(height: 10),
//                     Padding(
//                       padding: EdgeInsets.only(top: 25),
//                       child: Row(
//                         children: [
//                           Text(
//                             '₹110',
//                             style: TextStyle(
//                                 fontSize: 24,
//                                 fontWeight: FontWeight.w600,
//                                 color: Color.fromARGB(255, 208, 211, 21)),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.only(left: 58),
//                             child: ElevatedButton(
//                               onPressed: () {},
//                               child: Text('Add to Cart'),
//                               style: ElevatedButton.styleFrom(
//                                 primary: Colors.yellow
//                                     .shade400, // Change the button's background color
//                                 onPrimary: Colors
//                                     .black87, // Change the button's text color
//                                 shape: RoundedRectangleBorder(
//                                   // Make the button's corners rounded
//                                   borderRadius: BorderRadius.circular(20),
//                                 ),
//                               ),
//                             ),
//                           )
//                         ],
//                         //children: [

//                         //),
//                         //],
//                       ),
//                     ),
//                   ],
//                 ),
//               )
//             ],
//           )),
//       Padding(
//         padding: const EdgeInsets.only(top: 12),
//         child: Container(
//             padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(24),
//               color: Color.fromARGB(255, 57, 57, 56),
//             ),
//             child: Row(
//               children: [
//                 const Image(
//                   image: AppImages.biryani,
//                   height: 160.2,
//                   width: 120,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 30),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Chicken Biryani',
//                         style: TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                             color: Color.fromARGB(255, 237, 232, 232)),
//                       ),
//                       SizedBox(height: 12),
//                       Text(
//                         'Lorem Ipsum',
//                         style: TextStyle(
//                             fontSize: 14,
//                             color: Color.fromARGB(255, 237, 232, 232)),
//                       ),
//                       SizedBox(height: 10),
//                       Padding(
//                         padding: EdgeInsets.only(top: 25),
//                         child: Row(
//                           children: [
//                             Text(
//                               '₹110',
//                               style: TextStyle(
//                                   fontSize: 24,
//                                   fontWeight: FontWeight.w600,
//                                   color: Color.fromARGB(255, 208, 211, 21)),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(left: 58),
//                               child: ElevatedButton(
//                                 onPressed: () {},
//                                 child: Text('Add to Cart'),
//                                 style: ElevatedButton.styleFrom(
//                                   primary: Colors.yellow
//                                       .shade400, // Change the button's background color
//                                   onPrimary: Colors
//                                       .black87, // Change the button's text color
//                                   shape: RoundedRectangleBorder(
//                                     // Make the button's corners rounded
//                                     borderRadius: BorderRadius.circular(20),
//                                   ),
//                                 ),
//                               ),
//                             )
//                           ],
//                           //children: [

//                           //),
//                           //],
//                         ),
//                       ),
//                     ],
//                   ),
//                 )
//               ],
//             )),
//       ),
//       Padding(
//         padding: const EdgeInsets.only(top: 12),
//         child: Container(
//             padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(24),
//               color: Color.fromARGB(255, 57, 57, 56),
//             ),
//             child: Row(
//               children: [
//                 const Image(
//                   image: AppImages.biryani,
//                   height: 160.2,
//                   width: 120,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 30),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Chicken Biryani',
//                         style: TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                             color: Color.fromARGB(255, 237, 232, 232)),
//                       ),
//                       SizedBox(height: 12),
//                       Text(
//                         'Lorem Ipsum',
//                         style: TextStyle(
//                             fontSize: 14,
//                             color: Color.fromARGB(255, 237, 232, 232)),
//                       ),
//                       SizedBox(height: 10),
//                       Padding(
//                         padding: EdgeInsets.only(top: 25),
//                         child: Row(
//                           children: [
//                             Text(
//                               '₹110',
//                               style: TextStyle(
//                                   fontSize: 24,
//                                   fontWeight: FontWeight.w600,
//                                   color: Color.fromARGB(255, 208, 211, 21)),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(left: 58),
//                               child: ElevatedButton(
//                                 onPressed: () {},
//                                 child: Text('Add to Cart'),
//                                 style: ElevatedButton.styleFrom(
//                                   primary: Colors.yellow
//                                       .shade400, // Change the button's background color
//                                   onPrimary: Colors
//                                       .black87, // Change the button's text color
//                                   shape: RoundedRectangleBorder(
//                                     // Make the button's corners rounded
//                                     borderRadius: BorderRadius.circular(20),
//                                   ),
//                                 ),
//                               ),
//                             )
//                           ],
//                           //children: [

//                           //),
//                           //],
//                         ),
//                       ),
//                     ],
//                   ),
//                 )
//               ],
//             )),
//       ),
//       Padding(
//         padding: const EdgeInsets.only(top: 12),
//         child: Container(
//             padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(24),
//               color: Color.fromARGB(255, 57, 57, 56),
//             ),
//             child: Row(
//               children: [
//                 const Image(
//                   image: AppImages.biryani,
//                   height: 160.2,
//                   width: 120,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 30),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Chicken Biryani',
//                         style: TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                             color: Color.fromARGB(255, 237, 232, 232)),
//                       ),
//                       SizedBox(height: 12),
//                       Text(
//                         'Lorem Ipsum',
//                         style: TextStyle(
//                             fontSize: 14,
//                             color: Color.fromARGB(255, 237, 232, 232)),
//                       ),
//                       SizedBox(height: 10),
//                       Padding(
//                         padding: EdgeInsets.only(top: 25),
//                         child: Row(
//                           children: [
//                             Text(
//                               '₹110',
//                               style: TextStyle(
//                                   fontSize: 24,
//                                   fontWeight: FontWeight.w600,
//                                   color: Color.fromARGB(255, 208, 211, 21)),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(left: 58),
//                               child: ElevatedButton(
//                                 onPressed: () {},
//                                 child: Text('Add to Cart'),
//                                 style: ElevatedButton.styleFrom(
//                                   primary: Colors.yellow
//                                       .shade400, // Change the button's background color
//                                   onPrimary: Colors
//                                       .black87, // Change the button's text color
//                                   shape: RoundedRectangleBorder(
//                                     // Make the button's corners rounded
//                                     borderRadius: BorderRadius.circular(20),
//                                   ),
//                                 ),
//                               ),
//                             )
//                           ],
//                           //children: [

//                           //),
//                           //],
//                         ),
//                       ),
//                     ],
//                   ),
//                 )
//               ],
//             )),
//       ),
//       Padding(
//         padding: const EdgeInsets.only(top: 12),
//         child: Container(
//             padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(24),
//               color: Color.fromARGB(255, 57, 57, 56),
//             ),
//             child: Row(
//               children: [
//                 const Image(
//                   image: AppImages.biryani,
//                   height: 160.2,
//                   width: 120,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 30),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Chicken Biryani',
//                         style: TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                             color: Color.fromARGB(255, 237, 232, 232)),
//                       ),
//                       SizedBox(height: 12),
//                       Text(
//                         'Lorem Ipsum',
//                         style: TextStyle(
//                             fontSize: 14,
//                             color: Color.fromARGB(255, 237, 232, 232)),
//                       ),
//                       SizedBox(height: 10),
//                       Padding(
//                         padding: EdgeInsets.only(top: 25),
//                         child: Row(
//                           children: [
//                             Text(
//                               '₹110',
//                               style: TextStyle(
//                                   fontSize: 24,
//                                   fontWeight: FontWeight.w600,
//                                   color: Color.fromARGB(255, 208, 211, 21)),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(left: 58),
//                               child: ElevatedButton(
//                                 onPressed: () {},
//                                 child: Text('Add to Cart'),
//                                 style: ElevatedButton.styleFrom(
//                                   primary: Colors.yellow
//                                       .shade400, // Change the button's background color
//                                   onPrimary: Colors
//                                       .black87, // Change the button's text color
//                                   shape: RoundedRectangleBorder(
//                                     // Make the button's corners rounded
//                                     borderRadius: BorderRadius.circular(20),
//                                   ),
//                                 ),
//                               ),
//                             )
//                           ],
//                           //children: [

//                           //),
//                           //],
//                         ),
//                       ),
//                     ],
//                   ),
//                 )
//               ],
//             )),
//       ),
//     ])))));
//   }
// }

//Caraousel code

// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';

// class Home extends StatefulWidget {
//   const Home({super.key});

//   @override
//   State<Home> createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   List imageList = [
//     {"id": 1, "image_path": AppImages.prawn},
//     {"id": 2, "image_path": AppImages.dish},
//     {"id": 3, "image_path": AppImages.dish2},
//   ];
//   final CarouselController carouselController = CarouselController();
//   int currentIndex = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           centerTitle: true,
//           title: const Text("Slider Example"),
//         ),
//         body: Column(children: [
//           Stack(children: [
//             InkWell(
//               onTap: () {
//                 print(currentIndex);
//               },
//               child: CarouselSlider(
//                 items: imageList
//                     .map(
//                       (item) => Image.asset(
//                         item('image_path'),
//                         fit: BoxFit.cover,
//                         width: double.infinity,
//                       ),
//                     )
//                     .toList(),
//                 carouselController: carouselController,
//                 options: CarouselOptions(
//                   scrollPhysics: const BouncingScrollPhysics(),
//                   autoPlay: true,
//                   aspectRatio: 2,
//                   viewportFraction: 1,
//                   onPageChanged: (index, reason) {
//                     setState(() {
//                       currentIndex = index;
//                     });
//                   },
//                 ),
//               ),
//             ),
//             Positioned(
//                 bottom: 10,
//                 left: 0,
//                 right: 0,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: imageList.asMap().entries.map((entry) {
//                     print(entry);
//                     print(entry.key);
//                     return GestureDetector(
//                         onTap: () =>
//                             carouselController.animateToPage(entry.key),
//                         child: Container(
//                           width: currentIndex == entry.key ? 17 : 7,
//                           height: 7.0,
//                           margin: const EdgeInsets.symmetric(
//                             horizontal: 3.0,
//                           ),
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(10),
//                               color: currentIndex == entry.key
//                                   ? Colors.red
//                                   : Colors.teal),
//                         ));
//                   }).toList(),
//                 )),
//           ])
//         ]));
//   }
// }

//Carousel code

// import 'package:flutter/material.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: const Home(),
//     );
//   }
// }

// class Home extends StatefulWidget {
//   const Home({Key? key}) : super(key: key);

//   @override
//   State<Home> createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   int currentIndex = 0;
//   final PageController controller = PageController();

//   List<String> images = [
//     "https://picsum.photos/id/240/200/200",
//     "https://picsum.photos/id/241/200/300",
//     "https://picsum.photos/id/242/200/300",
//     "https://picsum.photos/id/243/200/300",
//     "https://picsum.photos/id/244/200/300",
//     "https://picsum.photos/id/250/200/300",
//     "https://picsum.photos/id/251/200/300",
//     "https://picsum.photos/id/252/200/300",
//     "https://picsum.photos/id/253/200/300",
//     "https://picsum.photos/id/254/200/300",
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           SizedBox(
//             height: 250,
//             width: double.infinity,
//             child: PageView.builder(
//               controller: controller,
//               onPageChanged: (index) {
//                 setState(() {
//                   currentIndex = index % images.length;
//                 });
//               },
//               itemBuilder: (context, index) {
//                 return Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 1),
//                   child: SizedBox(
//                     height: 200,
//                     width: double.infinity,
//                     child: Image.network(
//                       images[index % images.length],
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               for (var i = 0; i < images.length; i++)
//                 buildIndicator(currentIndex == i)
//             ],
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 IconButton(
//                   onPressed: () {
//                     controller.jumpToPage(currentIndex - 1);
//                   },
//                   icon: Icon(Icons.arrow_back),
//                 ),
//                 IconButton(
//                   onPressed: () {
//                     controller.jumpToPage(currentIndex + 1);
//                   },
//                   icon: Icon(Icons.arrow_forward),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget buildIndicator(bool isSelected) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 1),
//       child: Container(
//         height: isSelected ? 12 : 10,
//         width: isSelected ? 12 : 10,
//         decoration: BoxDecoration(
//           shape: BoxShape.circle,
//           color: isSelected ? Colors.yellow.shade300 : Colors.white54,
//         ),
//       ),
//     );
//   }
// }

//Search bar

// class Home extends StatefulWidget {
//   const Home({Key? key}) : super(key: key);

//   @override
//   _HomeState createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   final List<Map<String, dynamic>> _allUsers = [
//     {"id": 1, "name": "Andy", "age": 29},
//     {"id": 2, "name": "Aragon", "age": 40},
//     {"id": 3, "name": "Bob", "age": 5},
//     {"id": 4, "name": "Barbara", "age": 35},
//     {"id": 5, "name": "Candy", "age": 21},
//     {"id": 6, "name": "Colin", "age": 55},
//     {"id": 7, "name": "Audra", "age": 30},
//     {"id": 8, "name": "Banana", "age": 14},
//     {"id": 9, "name": "Caversky", "age": 100},
//     {"id": 10, "name": "Becky", "age": 32},
//   ];

//   // This list holds the data for the list view
//   List<Map<String, dynamic>> _foundUsers = [];
//   @override
//   initState() {
//     _foundUsers = _allUsers;
//     super.initState();
//   }

//   // This function is called whenever the text field changes
//   void _runFilter(String enteredKeyword) {
//     List<Map<String, dynamic>> results = [];
//     if (enteredKeyword.isEmpty) {
//       // if the search field is empty or only contains white-space, we'll display all users
//       results = _allUsers;
//     } else {
//       results = _allUsers
//           .where((user) =>
//               user["name"].toLowerCase().contains(enteredKeyword.toLowerCase()))
//           .toList();
//       // we use the toLowerCase() method to make it case-insensitive
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(

//         title: const Text('Search Listview'),
//       ),
//       body: Padding(

//         padding: const EdgeInsets.all(10),
//         child: Column(
//           children: [
//             const SizedBox(
//               height: 20,
//             ),
//             TextField(
//               onChanged: (value) => _runFilter(value),
//               decoration: const InputDecoration(
//                   labelText: 'Search', suffixIcon: Icon(Icons.search)),
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             Expanded(
//               child: _foundUsers.isNotEmpty
//                   ? ListView.builder(
//                       itemCount: _foundUsers.length,
//                       itemBuilder: (context, index) => Card(
//                         key: ValueKey(_foundUsers[index]["id"]),
//                         color: Colors.blue,
//                         elevation: 4,
//                         margin: const EdgeInsets.symmetric(vertical: 10),
//                         child: ListTile(
//                           leading: Text(
//                             _foundUsers[index]["id"].toString(),
//                             style: const TextStyle(
//                                 fontSize: 24, color: Colors.white),
//                           ),
//                           title: Text(_foundUsers[index]['name'],
//                               style: TextStyle(color: Colors.white)),
//                           subtitle: Text(
//                               '${_foundUsers[index]["age"].toString()} years old',
//                               style: TextStyle(color: Colors.white)),
//                         ),
//                       ),
//                     )
//                   : const Text(
//                       'No results found',
//                       style: TextStyle(fontSize: 24),
//                     ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// Search Bar
// class Home extends StatefulWidget {
//   const Home({super.key});

//   @override
//   State<Home> createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   static List<MovieModel> main_movies_list = [
//     MovieModel("The Shawashank Redemption", 1994, 9.3,
//         "https://picsum.photos/id/240/200/200"),
//     MovieModel(
//         "The Godfather", 1972, 7.8, "https://picsum.photos/id/241/200/200"),
//     MovieModel("Drishyam", 1978, 7.6, "https://picsum.photos/id/242/200/200"),
//     MovieModel("Soul", 1977, 3.8, "https://picsum.photos/id/243/200/200"),
//     MovieModel(
//         "Shutter Island", 1982, 7.9, "https://picsum.photos/id/244/200/200"),
//   ];

//   //creating the list that we r going to display and filter
//   List<MovieModel> display_list = List.from(main_movies_list);

//   void updateList(String value) {
//     //this is the function that will filter our list
//     //we will be back to this list after a while
//     setState(() {
//       display_list = main_movies_list
//           .where((element) =>
//               element.movie_title!.toLowerCase().contains(value.toLowerCase()))
//           .toList();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFF1F1545),
//       appBar: AppBar(
//         backgroundColor: Color(0xFF1F1545),
//         elevation: 0.0,
//       ),
//       body: Padding(
//           padding: EdgeInsets.all(16),
//           child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "Search for a Movie",
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 22.0,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 SizedBox(
//                   height: 20.0,
//                 ),
//                 TextField(
//                   onChanged: (value) => updateList(value),
//                   style: TextStyle(color: Colors.white),
//                   decoration: InputDecoration(
//                     filled: true,
//                     fillColor: Color(0xff302360),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8.0),
//                       borderSide: BorderSide.none,
//                     ),
//                     hintText: "eg: The Dark Knight",
//                     prefixIcon: Icon(Icons.search),
//                     prefixIconColor: Colors.purple.shade900,
//                   ),
//                 ),
//                 SizedBox(
//                   height: 20.0,
//                 ),
//                 Expanded(
//                     //Now lets craete a func to display a text in acse we dont get result

//                     child: display_list.length == 0
//                         ? Center(
//                             child: Text(
//                             "Now Result found",
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 22.0,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ))
//                         : ListView.builder(
//                             itemCount: display_list.length,
//                             itemBuilder: (context, index) => ListTile(
//                                 contentPadding: EdgeInsets.all(8.0),
//                                 title: Text(
//                                   display_list[index].movie_title!,
//                                   style: TextStyle(
//                                       color: Colors.white,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                                 subtitle: Text(
//                                   '${display_list[index].movie_release_year!}',
//                                   style: TextStyle(
//                                     color: Colors.white60,
//                                   ),
//                                 ),
//                                 trailing: Text(
//                                   "${display_list[index].rating}",
//                                   style: TextStyle(color: Colors.amber),
//                                 )),
//                           ))
//               ])),
//     );
//   }
// }

//search bar

// class Food {
//   final String name;
//   final String image;
//   final double price;
//   final String details;

//   Food({
//     required this.name,
//     required this.image,
//     required this.price,
//     required this.details,
//   });
// }

// class Home extends StatefulWidget {
//   @override
//   _HomeState createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   TextEditingController _searchController = TextEditingController();
//   String _searchText = "";
//   List<Food> _foodItems = [
//     Food(
//       name: 'Pizza',
//       image: 'AppImages.untitled',
//       price: 10.99,
//       details: 'Delicious pizza with assorted toppings.',
//     ),
//     Food(
//       name: 'Pasta',
//       image: 'AppImages.pasta',
//       price: 8.99,
//       details: 'Juicy beef burger with fresh vegetables.',
//     ),
//     Food(
//       name: 'Chicken',
//       image: 'AppImages.chicken',
//       price: 12.99,
//       details: 'Italian pasta with creamy sauce.',
//     ),
//     // Add more food items here...
//   ];
//   List<Food> _filteredFoodItems = [];

//   @override
//   void initState() {
//     super.initState();
//     _searchController.addListener(_onSearchChanged);
//     _filteredFoodItems = _foodItems;
//   }

//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }

//   void _onSearchChanged() {
//     String searchText = _searchController.text;
//     setState(() {
//       _searchText = searchText;
//       _filteredFoodItems = _foodItems.where((food) {
//         return food.name.toLowerCase().contains(searchText.toLowerCase());
//       }).toList();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Food App'),
//       ),
//       body: Column(
//         children: [
//           Container(
//             alignment: Alignment.topRight, // Align to the top right corner
//             child: CircleAvatar(
//               radius: 30,
//               backgroundImage: AssetImage(
//                   'AppImages.avatar'), // Replace with your own image path
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.all(16.0),
//             child: TextField(
//               controller: _searchController,
//               decoration: InputDecoration(
//                 labelText: 'Search',
//                 prefixIcon: const Icon(Icons.search_sharp),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10.0),
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(height: 16.0),
//           Expanded(
//             child: ListView.builder(
//               itemCount: _filteredFoodItems.length,
//               itemBuilder: (BuildContext context, int index) {
//                 Food foodItem = _filteredFoodItems[index];
//                 return Column(
//                   children: [
//                     Container(
//                       color: Colors.yellow.shade100,
//                       child: ListTile(
//                         leading: Image.asset(
//                           foodItem.image,
//                           width: 150,
//                           height: 150,
//                         ),
//                         title: Text(
//                           foodItem.name,
//                           style: TextStyle(
//                             fontSize: 28,
//                             fontWeight: FontWeight.w400,
//                             color: Colors.black,
//                           ),
//                         ),
//                         subtitle: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             SizedBox(height: 4),
//                             Text('Details: ${foodItem.details}'),
//                             SizedBox(height: 8),
//                             Row(
//                               children: [
//                                 Text(
//                                   ' \₹${foodItem.price.toStringAsFixed(2)}',
//                                   style: TextStyle(
//                                     fontSize: 24,
//                                     fontWeight: FontWeight.w400,
//                                     color: Colors.black,
//                                   ),
//                                 ),
//                                 SizedBox(width: 25),
//                                 ElevatedButton(
//                                   onPressed: () {},
//                                   child: Text('Add to Cart'),
//                                   style: ElevatedButton.styleFrom(
//                                     backgroundColor: Colors.yellow.shade400,
//                                     foregroundColor: Colors.black87,
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(20),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 16), // Separator height
//                   ],
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// search bar

class Food {
  final String name;
  final String image;
  final double price;
  final String details;

  Food({
    required this.name,
    required this.image,
    required this.price,
    required this.details,
  });
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int myIndex = 0;
  List<Widget> pages = [
    HomePage(),
    ProductsPage(),
    DietPage(),
    SchedulePage(),
  ];

  TextEditingController _searchController = TextEditingController();
  String _searchText = "";
  List<Food> _foodItems = [
    Food(
      name: 'Pizza',
      image: 'assets/images/pizza.jpeg',
      price: 10.99,
      details: 'Delicious pizza with assorted toppings.',
    ),
    Food(
      name: 'Pasta',
      image: 'assets/images/pasta.jpeg',
      price: 8.99,
      details: 'Juicy beef burger with fresh vegetables.',
    ),
    Food(
      name: 'Chicken',
      image: 'assets/images/chicken.jpeg',
      price: 12.99,
      details: 'Italian pasta with creamy sauce.',
    ),
    Food(
      name: 'Pizza',
      image: 'assets/images/pizza.jpeg',
      price: 10.99,
      details: 'Delicious pizza with assorted toppings.',
    ),
    Food(
      name: 'Pasta',
      image: 'assets/images/pasta.jpeg',
      price: 8.99,
      details: 'Juicy beef burger with fresh vegetables.',
    ),
    Food(
      name: 'Chicken',
      image: 'assets/images/Untitled.png',
      price: 12.99,
      details: 'Italian pasta with creamy sauce.',
    ),
    // Add more food items here...
  ];
  List<Food> _filteredFoodItems = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
    _filteredFoodItems = _foodItems;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    String searchText = _searchController.text;
    setState(() {
      _searchText = searchText;
      _filteredFoodItems = _foodItems.where((food) {
        return food.name.toLowerCase().contains(searchText.toLowerCase());
      }).toList();
    });
  }

  void navigateToPage(int index) {
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Home()),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SchedulePage()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProductsPage()),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DietPage()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Container(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () {
                    // Navigation logic goes here
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Home1()),
                    );
                  },
                  child: CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage('assets/images/avatar.png'),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    border: Border.all(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: TextField(
                    controller: _searchController,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: InputDecoration(
                      labelText: '',
                      labelStyle: TextStyle(
                        color: Colors.grey.shade300,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                      prefixIcon:
                          Icon(Icons.search_sharp, color: Colors.yellow),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              CarouselSlider(
                options: CarouselOptions(
                  height: 200.0,
                  enableInfiniteScroll: true,
                  autoPlay: true,
                ),
                items: _foodItems.map((Food food) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          image: DecorationImage(
                            image: AssetImage(food.image),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
              SizedBox(height: 26.0),
              Expanded(
                child: ListView.builder(
                  itemCount: _filteredFoodItems.length,
                  itemBuilder: (BuildContext context, int index) {
                    Food foodItem = _filteredFoodItems[index];
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black54,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: ListTile(
                              leading: AspectRatio(
                                aspectRatio:
                                    2, // Adjust this value as needed for the desired aspect ratio
                                child: Container(
                                  child: Image.asset(
                                    foodItem.image,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              title: Text(
                                foodItem.name,
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 4),
                                  Text(
                                    'Details: ${foodItem.details}',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white70,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Text(
                                        '₹${foodItem.price.toStringAsFixed(2)}',
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.yellow.shade400,
                                        ),
                                      ),
                                      SizedBox(width: 25),
                                      ElevatedButton(
                                        onPressed: () {},
                                        child: Text('Add to Cart'),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              Colors.yellow.shade400,
                                          foregroundColor: Colors.black87,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                      ],
                    );
                  },
                ),
              ),
              // Expanded(
              //   child: Center(
              //     child: pages[myIndex],
              //   ),
              // ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          if (index == myIndex) {
            // Return early if the selected index is already the current index
            return;
          }
          setState(() {
            myIndex = index;
            navigateToPage(myIndex);
          });
        },
        currentIndex: myIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.yellow.shade400,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.calendar_today,
              color: Colors.yellow.shade400,
            ),
            label: 'Schedule',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.shopping_cart,
              color: Colors.yellow.shade400,
            ),
            label: 'Products',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.restaurant_menu,
              color: Colors.yellow.shade400,
            ),
            label: 'Diet',
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Text('Home Page Content'),
      ),
    );
  }
}

class SchedulePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Schedule'),
      ),
      body: Center(
        child: Text('Schedule Page Content'),
      ),
    );
  }
}

class ProductsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
      ),
      body: Center(
        child: Text('Products Page Content'),
      ),
    );
  }
}

class DietPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Diet'),
      ),
      body: Center(
        child: Text('Diet Page Content'),
      ),
    );
  }
}
