import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:carousel_slider/carousel_slider.dart';

// components
import '../components/header.dart';
import '../components/foodCards.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<String> feed = [
                  'https://lh3.googleusercontent.com/u/0/d/17eW7kPjFsNt6FXhpDASUDFYEuHbbqlcn=w1909-h918-iv1',
                  'https://lh3.googleusercontent.com/u/0/d/17eW7kPjFsNt6FXhpDASUDFYEuHbbqlcn=w1909-h918-iv1',
                  'https://lh3.googleusercontent.com/u/0/d/17eW7kPjFsNt6FXhpDASUDFYEuHbbqlcn=w1909-h918-iv1',
  ];
  final CarouselController carouselController = CarouselController();
  int currentIndex = 0;

  List<Map<String, dynamic>> week = [
  {
    'day': 'Mon',
    'date': '21',
    'active':true,
  },
  {
    'day': 'Tue',
    'date': '22',
    'active':false,
  },
  {
    'day': 'Wed',
    'date': '23',
    'active':false,
  },
  {
    'day': 'Thu',
    'date': '24',
    'active':false,
  },
  {
    'day': 'Fri',
    'date': '25',
    'active':false,
  },
  {
    'day': 'Sat',
    'date': '26',
    'active':false,
  },
  {
    'day': 'Sun',
    'date': '27',
    'active':false,
  },
];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const Header(),
              CarouselSlider(
              options: CarouselOptions(
                autoPlay: true,
                aspectRatio: 16/9,
                viewportFraction: .96,
                onPageChanged: (index, reason) {
                  setState(() {
                    currentIndex = index;
                  });
                },
              ),
              items: feed
                .map((item) => Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Image(
                        image: NetworkImage(item),
                      ),
                    ))
                .toList()
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: feed.asMap().entries.map((entry) {
                return GestureDetector(
                  onTap: () => carouselController.animateToPage(entry.key),
                  child: Container(
                    width: 8.0,
                    height: 8.0,
                    margin: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 4.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: (Theme.of(context).brightness == Brightness.dark
                                ? HexColor('#D9D9D9')
                                : HexColor('#FECE2F')
                        )
                            .withOpacity(currentIndex== entry.key ? 0.9 : 0.4)),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 15),
            SizedBox(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal, // Horizontal scrolling
                children: week.map((dayData) {
                  return Stack(
                    children: [
                      Container(
                        width: 50, // Adjust card width as needed
                        decoration: BoxDecoration(
                          color: dayData['active'] ? HexColor('#FECE2F') : HexColor('#FFF2CE'), // Replace with your hex color code
                          borderRadius: BorderRadius.circular(12.0), // Set the border radius
                        ),
                        margin: const EdgeInsets.all(6),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              dayData['day'],
                              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                            ),
                            Text(
                              dayData['date'],
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                      if (dayData['active'])
                        Positioned(
                          bottom: -5,
                          left: 0,
                          right: 0,
                          child: Container(
                            width: 20, // Set the width
                            height: 20, // Set the height
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle, // Makes the container circular
                              color: Colors.white,
                            ),
                          ),
                        ),
                    ],
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 15),
            const Foods(),
            ],
          )
        )
      )
    );
  }
}
