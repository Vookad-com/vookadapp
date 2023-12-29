import 'dart:convert';

import 'package:Vookad/components/dateselector.dart';
import 'package:Vookad/config/colors.dart';
import 'package:Vookad/config/location.dart';
import 'package:Vookad/graphql/graphql.dart';
import 'package:Vookad/graphql/userquery.dart';
import 'package:Vookad/models/searchAddr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';


// components
import '../components/header.dart';
import '../components/foodCards.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final box = Hive.box<SearchAddr>('searchAddrBox');

  late Future<SearchAddr> fetchedloco = fetchLoco();
  List<String> feed = [
                  'https://lh3.googleusercontent.com/u/0/d/17eW7kPjFsNt6FXhpDASUDFYEuHbbqlcn=w1909-h918-iv1',
                  'https://lh3.googleusercontent.com/u/0/d/17eW7kPjFsNt6FXhpDASUDFYEuHbbqlcn=w1909-h918-iv1',
                  'https://lh3.googleusercontent.com/u/0/d/17eW7kPjFsNt6FXhpDASUDFYEuHbbqlcn=w1909-h918-iv1',
  ];
  final CarouselController carouselController = CarouselController();
  int currentIndex = 0;


  Future fetchData() async {
  SearchAddr location = await fetchedloco;
  var query = QueryOptions(document: gql(homequery), variables: {"location": [location.lng, location.lat],"bannerId": "656466326565303339333533"});
  final QueryResult result = await client.query(query);

  if (result.hasException) {
    print('Error: ${result.exception.toString()}');
    throw Exception("This is an error message.");
  } else {
    final Map<String, dynamic>? data = result.data;
    return data;
  }
}

  void locowatch(){
    final locolisten = box.watch();
    locolisten.listen((event) {
         setState(() {
            fetchedloco = fetchLoco();
         });
    });
  }

  @override
  void initState() {
    super.initState();
    locowatch();
  }

  Future<SearchAddr> fetchLoco() async {
    try {


      SearchAddr? addr = box.get('current');
      if (addr != null) {
        return addr;
      }
    } catch (e) {
      print('Error accessing Hive box: $e');
    }

    try {
      List<double> loco = await getLoco();
      final response = await http.get(Uri.parse(
          'https://api.mapbox.com/geocoding/v5/mapbox.places/${loco[1]},${loco[0]}.json?access_token=pk.eyJ1Ijoic2FoaWxjb2RlcjEiLCJhIjoiY2xhejYyOGdvMGlkajN3cnpnZXhvMGN3MSJ9.3kZ0cQL6qD9_JrFW557_0w'));
      final Map<String, dynamic> data = json.decode(response.body);
      String place = data["features"][0]["text"] ?? "";
      String placeName = data["features"][0]["place_name"] ?? "";
      String pincode = "";
      final List<dynamic> context = data['features'][0]['context'];
      for (var item in context) {
        if (item['id'].contains('postcode')) {
          pincode =  item['text'];
          break;
        }
      }
      return SearchAddr(placeName: placeName, place: place, lng: loco[1], lat: loco[0], pincode: pincode);
    } catch (e) {
      print('Error fetching location information: $e');
      // Handle the error or return a default value
      return SearchAddr(placeName: 'Ghatikia', place: 'OUTR', lng: 85.8429385, lat: 20.2661435, pincode: "751029");
    }

  }

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _handleRefresh,
        child: FutureBuilder(
        future: fetchData(),
        builder: (context, snapshot){
          if(snapshot.hasData){
            var data = snapshot.data["nearby"] as List;
            if(data.isEmpty){
              return SafeArea(
                  child:Container(
                    color: AppColors.white,
                    child: Stack(
                children: [
                  Center(
                child: SvgPicture.asset(
                        "assets/noservice.svg",
                      ),
              ),
                  Header(fetchedloco: fetchedloco,),
                ],
              ),
                  )
              );
            }

            return SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Header(fetchedloco: fetchedloco,),
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
            const DateSelector(),
            const SizedBox(height: 15),
            Foods(dataList: (snapshot.data["nearby"] as List)
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
                child: Center(
                  child: Stack(
                    children: [
                      SvgPicture.asset(
                        "assets/network.svg",
                      ),
                      const Positioned(
                        // left: 50,
                        child: SizedBox(
                          height: 400,
                          child: Center(
                            child: Text("No Internet", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
                          ),
                        ),
                      )
                    ],
                  ),
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
