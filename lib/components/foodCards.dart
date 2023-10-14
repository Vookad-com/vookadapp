import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class Foods extends StatefulWidget {
  const Foods({super.key});

  @override
  State<Foods> createState() => _FoodsState();
}

class _FoodsState extends State<Foods> {

  List<Map<String, dynamic>> types = [
    {
      'title':'All',
      'active': false,
    },{
      'title':'Breakfast',
      'active': true,
    },
    {
      'title':'Lunch',
      'active': false,
    },
    {
      'title':'Snacks',
      'active': false,
    },{
      'title':'Dinner',
      'active': false,
    },
  ];

  List<Map<String,dynamic>> meals = [
    {
      'name': 'Chicken Meal',
      'descrip':'A butter chicken meal with naan is a delicious Indian dish consisting of tender',
      'pricing': 69,
      'img': 'https://lh3.googleusercontent.com/u/0/drive-viewer/AK7aPaCVPTgw2_kbe_7z1U75vuLCODtEt9PJL6h3HgjJHeP53QGpkUzvEcFwdxon1op52l1Q2xI8AJrHk9mrJ68BYnP4Ap7f=w2234-h1538'
    },{
      'name': 'Paneer Masala',
      'descrip':'A butter chicken meal with naan is a delicious Indian dish consisting of tender',
      'pricing': 69,
      'img': 'https://lh3.googleusercontent.com/u/0/drive-viewer/AK7aPaBykd1ToBugwQjLVQYOm0yUU92pGhLB3Vp9Fap-O8vEQhHc6yWlrGYx9Q8EPw52HA8v6CF8dOkStjN2D6puVVRhHJcOcA=w1909-h918'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
              height: 40,
              child: Row(
                children: types.map((e) {
                  return Expanded(flex: 1,child: Container(
                    decoration: BoxDecoration(
                      color: e['active'] ? HexColor('#FECE2F') : HexColor('#FFF2CE'), // Replace with your hex color code
                      borderRadius: BorderRadius.circular(16.0), // Set the border radius
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 2.0),
                    child: Center(
                      child: Text(e['title'],style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)
                    ),),
                  ));
                }).toList(),
              ),
            ),
            Container(
              margin:const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              child: const Row(
              children: <Widget>[
                Text("Popular",style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                          Text("See All",style: TextStyle(color: Color(0xFFFF8023),)),
                          Icon(Icons.keyboard_arrow_right, color: Color(0xFFFF8023)),
                      ],
                    )
                )
              ],
            ),
            ),
            Column(
              // height: 150,
              children: meals.map((e){
                       return Container(
                           height: 120,
                           margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                           decoration: BoxDecoration(
                              color: HexColor('#FFF6DE') , // Replace with your hex color code
                              borderRadius: BorderRadius.circular(8.0), // Set the border radius
                            ),
                           child: Row(
                             children: <Widget>[
                               Expanded(
                                 flex:1,
                                 child: SizedBox(
                                   height: 120,
                                   width: 100,
                                   child: ClipRRect(
                                     borderRadius: BorderRadius.circular(8.0),
                                     child: Image(
                                             image:NetworkImage(e['img']),
                                             fit: BoxFit.cover,
                                           ),
                                   ),
                                 ),
                               ),
                               Expanded(
                                   flex: 3,
                                   child: Padding(
                                     padding: const EdgeInsets.all(10.0),
                                     child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                       children: <Widget>[
                                         Text(e['name'],style: const TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 16,
                                                    ),),
                                         Text(e['descrip'],style: const TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      color: Color(0xFF666666),
                                                      fontSize: 9,
                                                    ),),
                                         Row(
                                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                           children: <Widget>[
                                             Text("₹ ${e['pricing']}",style: const TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      color: Color(0xFFFF8023),
                                                      fontSize: 16,
                                                    ),),
                                             Container(
                                               decoration: BoxDecoration(
                                                  color: const Color(0xFFFF8023), // Set your desired background color here
                                                  borderRadius: BorderRadius.circular(100.0), // Optional: Add rounded corners
                                                ),
                                               width: 75,
                                               height: 20,
                                               child: const InkWell(
                                                // onTap: onPressed,
                                                  child: Center(
                                                    child: Text(
                                                      "Add to cart",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 10,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                               ),
                                             )
                                           ],
                                         ),
                                       ],
                                     ),
                                   )
                               )
                             ],
                           ),
                         ) ;
                     }).toList(),
          )
      ],
    );
  }
}
