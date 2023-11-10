import 'package:Vookad/graphql/graphql.dart';
import 'package:Vookad/graphql/userquery.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

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

  Future fetchData() async {
  var query = QueryOptions(document: gql(home), variables: const {"family": "menu","bannerId": "656466326565303339333533"});
  final QueryResult result = await client.query(query);

  if (result.hasException) {
    print('Error: ${result.exception.toString()}');
    throw Exception("This is an error message.");
  } else {
    final Map<String, dynamic>? data = result.data;
    return data;
  }
}

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
      body: RefreshIndicator(
        onRefresh: _handleRefresh,
        child: FutureBuilder(
        future: fetchData(),
        builder: (context, snapshot){
          if(snapshot.hasData){
            return SafeArea(
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
              items: (snapshot.data["banner"]["gallery"] as List<dynamic>)
                .map((item) => Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Image(
                        image: NetworkImage(item["url"]),
                      ),
                    ))
                .toList()
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:  (snapshot.data["banner"]["gallery"] as List<dynamic>).asMap().entries.map((entry) {
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
            Foods(dataList: (snapshot.data["inventoryItems"] as List)
            .map((item) => item as Map<String, dynamic>)
            .toList(),),
            const SizedBox(height: 30),
            ],
          )
        )
      );
          } else if(snapshot.hasError){
            return SafeArea(child: SingleChildScrollView(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                child: const Center(
                  child: Text("Network Problem \n Try reloading"),
            ),),
              ));
          }
          else {
            return const Center(
              child: Text("Loading"),
            );
          }
        },
      ),
      ),
    );
  }
  Future<void> _handleRefresh() async {
    final refreshed = await fetchData();
    setState(() {
    });
  }
}
