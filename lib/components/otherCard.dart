import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hexcolor/hexcolor.dart';
import '../config/colors.dart';
import '../config/filtertags.dart';
import '../models/filter.dart';
import '../models/product.dart';

import 'package:hive/hive.dart';
class OFoods extends StatefulWidget {
  final List<Map<String, dynamic>> dataList;
  const OFoods({super.key, required this.dataList});

  @override
  State<OFoods> createState() => _OFoodsState();
}

class _OFoodsState extends State<OFoods> {
  String currentfilter = "All";
  List<Map<String, dynamic>> dataList = [];
  List<Filter> types = [];
  Future<void> updateProductInHive(BuildContext context,String pdtId, String categoryId, double price, String chefId) async {
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
    (product, ) => product.pdtId == pdtId && product.categoryId == categoryId && product.chefId == chefId,
    orElse: () => null,
  );

  if (existingProduct != null) {
    // If the product exists, increment its quantity.
    existingProduct.quantity += 1;
    await existingProduct.save(); // Save the updated product.
  } else {
    // If the product doesn't exist, create a new entry in the box.
    final newProduct = Product(pdtId: pdtId, categoryId: categoryId, chefId: chefId);
    await box.add(newProduct); // Add the new product to the box.
  }


  context.pop();
}
  @override
  void initState() {
    super.initState();
    types.addAll([Filter("All", true), Filter("Breakfast", false), Filter("Lunch", false), Filter("Snacks", false), Filter("Dinner", false)]);
    dataList = filtertagsS(widget.dataList, currentfilter);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
              height: 40,
              child: Row(
                children: types.map((e) {
                  return Expanded(
                    flex: 1,
                    child: InkWell(
                    onTap: (){
                      currentfilter = e.tag;
                      for (Filter tag in types){
                        if(tag.tag == currentfilter){
                          tag.active = true;
                          continue;
                        }
                        tag.active = false;
                      }
                      setState(() {
                        types = [...types];
                        dataList = filtertagsS(widget.dataList, currentfilter);
                      });
                    },
                    child: Container(
                    decoration: BoxDecoration(
                      color: e.active ? HexColor('#FECE2F') : HexColor('#FFF2CE'), // Replace with your hex color code
                      borderRadius: BorderRadius.circular(16.0), // Set the border radius
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 2.0),
                    child: Center(
                      child: Text(e.tag,style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)
                    ),),
                  )),
                  );
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
                       Map<String, dynamic> info = e;
                       return Container(
                           // height: 120,
                           margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                           decoration: BoxDecoration(
                              color: HexColor('#FFF6DE') , // Replace with your hex color code
                              borderRadius: BorderRadius.circular(8.0), // Set the border radius
                            ),
                           child: Row(
                             children: <Widget>[
                               Expanded(
                                 flex:1,
                                 child: InkWell(
                                   onTap: () => _zoomSheet(context, e,info["category"], info["_id"], "6543ad8f0844d7ab55ef821f"),
                                   child: SizedBox(
                                   // height: 120,
                                   child: ClipRRect(
                                     borderRadius: BorderRadius.circular(8.0),
                                     child: Image(
                                             image:NetworkImage(info["gallery"][0]["url"]),
                                             fit: BoxFit.cover,
                                           ),
                                   ),
                                 ),
                                 ),
                               ),
                               Expanded(
                                   flex: 2,
                                   child: Column(
                                     crossAxisAlignment: CrossAxisAlignment.end,
                                     children: [
                                       Padding(
                                     padding: const EdgeInsets.all(10.0),
                                     child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                       children: <Widget>[
                                         Text(info['name'],style: const TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 16,
                                                    ),),
                                         Text(info['description'],style: const TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      color: Color(0xFF666666),
                                                      fontSize: 9,
                                                    ),),
                                         Row(
                                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                           children: <Widget>[
                                             Text("₹ ${info["category"][0]['price']}",style: const TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      color: Color(0xFFFF8023),
                                                      fontSize: 16,
                                                    ),),
                                             Text(info["category"][0]['name']),
                                             Container(
                                               decoration: BoxDecoration(
                                                  color: const Color(0xFFFF8023), // Set your desired background color here
                                                  borderRadius: BorderRadius.circular(100.0), // Optional: Add rounded corners
                                                ),
                                               width: 75,
                                               height: 20,
                                               child: InkWell(
                                                onTap: () => _displayBottomSheet(context, info["category"], info["_id"], "6543ad8f0844d7ab55ef821f"),
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
                                     ],
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
  Future _displayBottomSheet(BuildContext context, List<Object?> data, String pdtId, String ChefId) {
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
                                                onTap: () => updateProductInHive(context, pdtId,e is Map<String, dynamic> ? e['_id'] : '', e is Map<String, dynamic> ? e['price'] is int? e['price'].toDouble():e['price']  : 0,ChefId),
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
    Future _zoomSheet(BuildContext context,Map<String, dynamic> e, List<Object?> data, String pdtId, String ChefId) {
    Map<String, dynamic> info = e;
    return showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
        builder: (context) => Container(
                                // color: AppColors.bgSecondary,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                margin: const EdgeInsets.all(10),
                                child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 10),
                                    child: ListView(
                                    children: <Widget>[
                               CarouselSlider(
                                options: CarouselOptions(
                                  autoPlay: true,
                                  aspectRatio: 1,
                                  viewportFraction: .96,
                                ),
                                items: (info["gallery"] as List<dynamic>)
                                  .map((item) => Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 8),
                                  child: ClipRRect(
                                            borderRadius: BorderRadius.circular(8.0),
                                            child: Image(
                                                    height: MediaQuery.of(context).size.height * 0.4,
                                                    image:NetworkImage(item["url"]),
                                                    fit: BoxFit.fitWidth,
                                                  ),

                                        ),
                                ))
                                  .toList()
                                ),
                               Column(
                                     crossAxisAlignment: CrossAxisAlignment.end,
                                     children: [
                                       Padding(
                                     padding: const EdgeInsets.all(10.0),
                                     child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                       children: <Widget>[
                                         Text(info['name'],style: const TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 18,
                                                    ),),
                                         Text(info['description'],style: const TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      color: Color(0xFF666666),
                                                      fontSize: 10,
                                                    ),),
                                          const Text("Size", style: TextStyle(fontSize: 16, color: AppColors.bgPrimary,fontWeight: FontWeight.w600),),
                                      ...data.map((e) => Container(
                                        margin: const EdgeInsets.symmetric(vertical: 10),
                                        child: Row(
                                          children: [
                                            Expanded(flex: 2,child: Text("${e is Map<String, dynamic> ? e['name'] : ''}")),
                                            Expanded(flex:1,child: Text("₹ ${e is Map<String, dynamic> ? e['price'] : ''}")),
                                            Expanded(
                                                flex: 1,
                                                child: InkWell(
                                                onTap: () => updateProductInHive(context, pdtId,e is Map<String, dynamic> ? e['_id'] : '', e is Map<String, dynamic> ? e['price'] is int? e['price'].toDouble():e['price']  : 0,ChefId),
                                                child: Container(
                                               decoration: BoxDecoration(
                                                  color: const Color(0xFFFF8023), // Set your desired background color here
                                                  borderRadius: BorderRadius.circular(100.0), // Optional: Add rounded corners
                                                ),
                                               width: 90,
                                               height: 25,
                                               child: const Center(
                                                    child: Text(
                                                      "Add",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                               ),
                                             ))
                                          ],
                                        ),
                                      )),
                                       ],
                                     ),
                                   )
                                     ],
                                   )
                             ]
                                )
                              )
                            ));
  }
}
