import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hexcolor/hexcolor.dart';
import '../config/colors.dart';
import '../models/product.dart';

import 'package:hive/hive.dart';

class Foods extends StatelessWidget {
  final List<Map<String, dynamic>> dataList;
  const Foods({super.key, required this.dataList});

  Future<void> updateProductInHive(BuildContext context,String pdtId, String categoryId, double price) async {
  final box = await Hive.openBox('products'); // Open a Hive box named 'products'.
  final items = await Hive.openBox('cart');
  final inst = items.get('total');
  int current = price.toInt();
  print(current);
  if(inst!=null){
    int total = inst;
    total+=current;
    await items.put('total', total);
  } else{
    await items.put('total', current);
  }

  // Check if a product with the given pdtId and categoryId exists in the box.
  final existingProduct = box.values.firstWhere(
    (product, ) => product.pdtId == pdtId && product.categoryId == categoryId,
    orElse: () => null,
  );

  if (existingProduct != null) {
    // If the product exists, increment its quantity.
    existingProduct.quantity += 1;
    await existingProduct.save(); // Save the updated product.
  } else {
    // If the product doesn't exist, create a new entry in the box.
    final newProduct = Product(pdtId: pdtId, categoryId: categoryId);
    await box.add(newProduct); // Add the new product to the box.
  }


  context.pop();
}

  @override
  Widget build(BuildContext context) {
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
              children: dataList.map((e){
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
                                             image:NetworkImage(e["gallery"][0]["url"]),
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
                                         Text(e['description'],style: const TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      color: Color(0xFF666666),
                                                      fontSize: 9,
                                                    ),),
                                         Row(
                                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                           children: <Widget>[
                                             Text("₹ ${e["category"][0]['price']}",style: const TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      color: Color(0xFFFF8023),
                                                      fontSize: 16,
                                                    ),),
                                             Text(e["category"][0]['name']),
                                             Container(
                                               decoration: BoxDecoration(
                                                  color: const Color(0xFFFF8023), // Set your desired background color here
                                                  borderRadius: BorderRadius.circular(100.0), // Optional: Add rounded corners
                                                ),
                                               width: 75,
                                               height: 20,
                                               child: InkWell(
                                                onTap: () => _displayBottomSheet(context, e["category"], e["_id"]),
                                                  child: const Center(
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
  Future _displayBottomSheet(BuildContext context, List<Object?> data, String pdtId) {
    return showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
        builder: (context) => Container(
                                // color: AppColors.bgSecondary,
                                height: 200,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                margin: const EdgeInsets.all(10),
                                child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                    child: ListView(
                                    children: [
                                      const Text("Size", style: TextStyle(fontSize: 16, color: AppColors.bgPrimary,fontWeight: FontWeight.w600),),
                                      ...data.map((e) => Container(
                                        margin: const EdgeInsets.symmetric(vertical: 10),
                                        child: Row(
                                          children: [
                                            Expanded(flex: 2,child: Text("${e is Map<String, dynamic> ? e['name'] : ''}")),
                                            Expanded(flex:1,child: Text("₹ ${e is Map<String, dynamic> ? e['price'] : ''}")),
                                            Expanded(
                                                flex: 1,
                                                child: Container(
                                               decoration: BoxDecoration(
                                                  color: const Color(0xFFFF8023), // Set your desired background color here
                                                  borderRadius: BorderRadius.circular(100.0), // Optional: Add rounded corners
                                                ),
                                               width: 75,
                                               height: 20,
                                               child: InkWell(
                                                onTap: () => updateProductInHive(context, pdtId,e is Map<String, dynamic> ? e['_id'] : '', e is Map<String, dynamic> ? e['price'] is int? e['price'].toDouble():e['price']  : 0),
                                                  child: const Center(
                                                    child: Text(
                                                      "Add",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 10,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                               ),
                                             ))
                                          ],
                                        ),
                                      ))
                                    ]
                                )
                              )
                            ));
  }
}

