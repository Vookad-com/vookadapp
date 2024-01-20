import 'package:Vookad/config/filtertags.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:Vookad/models/filter.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import '../config/colors.dart';
import '../models/product.dart';

import 'package:hive/hive.dart';

class Foods extends StatefulWidget {
  final List<Map<String, dynamic>> dataList;
  const Foods({super.key, required this.dataList});

  @override
  State<Foods> createState() => _FoodsState();
}


class _FoodsState extends State<Foods>  {
  String currentfilter = "All";
  List<Map<String, dynamic>> dataList = [];
  List<Filter> types = [];
  Future<void> updateProductInHive(BuildContext context,String pdtId, String categoryId, double price, String chefId) async {
    final box = await Hive.openBox('products'); // Open a Hive box named 'products'.
    final items = Hive.box('cart');
    final inst = items.get('total');
    items.put('chefid', chefId);
    int current = price.toInt();
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


  }

  @override
  void initState() {
    super.initState();
    types.addAll([Filter("All", true), Filter("Breakfast", false), Filter("Lunch", false), Filter("Snacks", false), Filter("Dinner", false)]);
  }


  @override
  Widget build(BuildContext context) {
    dataList = filtertags(widget.dataList, currentfilter);

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
                        // dataList = filtertags(widget.dataList, currentfilter);
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
                       Map<String, dynamic> info = e["info"][0];
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
                                 flex:2,
                                 child: SizedBox(
                                   width: 175,
                                   child: ClipRRect(
                                     borderRadius: BorderRadius.circular(8.0),
                                     child: InkWell(
                                       onTap: () => _zoomSheet(context, e,info["category"], info["_id"], e["ChefId"]),
                                       child: Column(
                                       children: [
                                         Image(
                                             image:NetworkImage(info["gallery"][0]["url"]),
                                             fit: BoxFit.cover,
                                           ),
                                         Container(
                                           color: AppColors.bgPrimary,
                                           padding: const EdgeInsets.symmetric(horizontal: 0,vertical: 2),
                                           child: Center(
                                             child: Text(
                                               "${(e["distance"]/1000).toStringAsFixed(1)} kms away",
                                               style: const TextStyle(color: AppColors.white, fontSize: 12,fontWeight: FontWeight.w500)
                                             ),
                                           ),
                                         )
                                       ],
                                     ),
                                     ),
                                   ),
                                 ),
                               ),
                               Expanded(
                                   flex: 3,
                                   child: Column(
                                     crossAxisAlignment: CrossAxisAlignment.end,
                                     children: [
                                       Padding(padding: const EdgeInsets.symmetric(horizontal: 10),
                                       child: Text("By ${e["displayname"]}", style: const TextStyle(color: AppColors.bgPrimary, fontWeight: FontWeight.bold,
                                                      fontSize: 14,),)
                                         ,),
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
                                         Row(
                                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                           children: <Widget>[
                                             Text("₹ ${info["category"][0]['price']}",style: const TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      color: Color(0xFFFF8023),
                                                      fontSize: 16,
                                                    ),),
                                             Text(info["category"][0]['name']),
                                             InkWell(
                                                onTap: () => _displayBottomSheet(context, info["category"], info["_id"], e["ChefId"]),
                                             child: Container(
                                               decoration: BoxDecoration(
                                                  color: const Color(0xFFFF8023), // Set your desired background color here
                                                  borderRadius: BorderRadius.circular(100.0), // Optional: Add rounded corners
                                                ),
                                               width: 90,
                                               height: 22,
                                               child: const Center(
                                                    child: Text(
                                                      "Add to cart",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 12,
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
                                                child: InkWell(
                                                onTap: () => _chefValidatorBox(context, pdtId,e is Map<String, dynamic> ? e['_id'] : '', e is Map<String, dynamic> ? e['price'] is int? e['price'].toDouble():e['price']  : 0,ChefId),
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
                                      ))
                                    ]
                                )
                              )
                            ));
  }
  Future _zoomSheet(BuildContext context,Map<String, dynamic> e, List<Object?> data, String pdtId, String ChefId) {
    Map<String, dynamic> info = e["info"][0];
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
                                       Padding(padding: const EdgeInsets.symmetric(horizontal: 10),
                                       child: Text("By ${e["displayname"]}", style: const TextStyle(color: AppColors.bgPrimary, fontWeight: FontWeight.bold,
                                                      fontSize: 14,),)
                                         ,),
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
                                                onTap: () => _chefValidatorBox(context, pdtId,e is Map<String, dynamic> ? e['_id'] : '', e is Map<String, dynamic> ? e['price'] is int? e['price'].toDouble():e['price']  : 0,ChefId),
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
  void _chefValidatorBox(BuildContext context,String pdtId, String categoryId, double price, String chefId){
    final items = Hive.box('cart');
    String? currentchefid = items.get('chefid');
    if(chefId != currentchefid && currentchefid !=null){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Clear Cart or Cancel?'),
          content: const Text('You can only order from one chef at a time!'),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await Hive.box('products').clear();
                await Hive.box('cart').clear();
                // ignore: use_build_context_synchronously
                updateProductInHive(context, pdtId, categoryId, price, chefId);
              },
              child: const Text('Clear', style: TextStyle(color: AppColors.bgPrimary),),
            ),
            TextButton(
              onPressed: () {
                // Handle 'Cancel' button press
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel', style: TextStyle(color: AppColors.bgPrimary),),
            ),
          ],
        );
      },
    );
    } else{
      updateProductInHive(context, pdtId, categoryId, price, chefId);
    }
  }
}

