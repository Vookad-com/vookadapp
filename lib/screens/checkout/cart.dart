import 'package:Vookad/components/cardHolder.dart';
import 'package:Vookad/models/pdtCat.dart';
import 'package:Vookad/models/product.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:Vookad/graphql/graphql.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import '../../config/colors.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {

  List<Map<String,dynamic>> regular = [];
  List<Map<String,dynamic>> subscription = [];
  List<Map<String,dynamic>> vproducts = [];
  double regTotal = 0;
  double subTotal = 0;
  double pdtTotal = 0;
  Future<bool>? data;
  @override
  void initState() {
    super.initState();
    data = getAllProducts(); // Initialize your Future or perform one-time setup here
  }

  void cartHandler(String pdtId,String categoryId, bool change,double price) async {
    final box = await Hive.openBox('products'); // Open a Hive box named 'products'.

    // Check if a product with the given pdtId and categoryId exists in the box.
    final pdt = box.values.firstWhere(
      (product, ) => product.pdtId == pdtId && product.categoryId == categoryId,
      orElse: () => null,
    );

    if (pdt != null) {
      if(change == false){
        // when user pressed for decrement
        if(pdt.quantity > 1){
          pdt.quantity--;
          pdt.save();
        } else{
          pdt.delete();
        }
      } else {
        pdt.quantity++;
        pdt.save();
      }
      final items = await Hive.openBox('cart');
      final inst = items.get('total');
      if(inst!=null){
        int total = inst;
        total += price.toInt()*(change?1:-1);
        await items.put('total', total);
      }
      if(box.length == 0){
        await items.put('total', 0);
      }
      setState(() {
        data = getAllProducts();
      });// Save the updated product.
    }
  }

  Future<bool> getAllProducts() async {

  final box = await Hive.openBox('products'); // Open the 'products' box.

  // Get all products from the box yup
  final products = box.values.cast<Product>().toList();
  regular.clear();
  subscription.clear();
  vproducts.clear();
  regTotal = 0;
  subTotal = 0;
  pdtTotal = 0;

  String pdtsQuery = """
  query GetInventoryItem {
  ${products.map((e) => 'pdt${e.categoryId} : getInventoryItem(id: "${e.pdtId}") {_id name family category {name price _id}}').join("\n")}
  }""";
  try {
    var query = QueryOptions(document: gql(pdtsQuery));
    final QueryResult result = await client.query(query);
    if (result.hasException) {
      throw Exception('Graphql error');
    } else {
      for (int index = 0; index < products.length; index++) {
        Product item = products[index];
        List<PdtCat> cats = (result.data?['pdt${item.categoryId}']["category"] as List<dynamic>).map((e) {
          return PdtCat(price: e["price"].toDouble(), categoryId: e["_id"], name: e["name"]);
        }).toList();
        PdtCat cat = cats.firstWhere((element)=> element.categoryId == item.categoryId);
        Map<String,dynamic> pdt = {...result.data?['pdt${item.categoryId}'], "category": cat,"quantity": item.quantity};
        switch (pdt["family"][0]) {
          case 'package':
            subscription.add(pdt);
            subTotal+= item.quantity*cat.price;
            break;
          case 'product':
            vproducts.add(pdt);
            pdtTotal+= item.quantity*cat.price;
            break;
          default:
            regTotal+=item.quantity*cat.price;
            regular.add(pdt);
            break;
        }
      }
    }
  } catch(e){
    if (kDebugMode) {
      print(["error in try block", e]);
    }
    return false;
  }
  setState(() {

  });
  return true;
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            bottomNavigationBar: Container(
              margin: const EdgeInsets.all(6),
              alignment: Alignment.center,
              height: 50,
              decoration: BoxDecoration(
                color: AppColors.bgPrimary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text("Pay ₹ ${regTotal+subTotal+pdtTotal}", style: const TextStyle(color: AppColors.white, fontSize: 18, fontWeight: FontWeight.w600),),
            ),
            body: SafeArea(
              child: FutureBuilder(
              future: data,
              builder: (context,snapshot) {
                if(snapshot.hasData){
                  if(snapshot.data == true){
                    return ListView(
                        children: [
                          const SizedBox(height: 10,),
                          Container(
                              margin: const EdgeInsets.all(5),
                              alignment: Alignment.centerLeft,
                              child: InkWell(
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
                                )),
                          regular.isNotEmpty ? CartHolder(pdttype: "Regular", pdts: regular, cartHandler: cartHandler,) : const SizedBox(),
                          subscription.isNotEmpty ? CartHolder(pdttype: "Subscriptions", pdts: subscription, cartHandler: cartHandler,) : const SizedBox(),
                          vproducts.isNotEmpty ? CartHolder(pdttype: "Regular", pdts: vproducts, cartHandler: cartHandler,) : const SizedBox(),
                  Container(
                    // color: AppColors.bgSecondary,
                    decoration: BoxDecoration(
                      color: AppColors.bgSecondary,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  margin: const EdgeInsets.all(10),
                  child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Bill Details", style: TextStyle(fontSize: 16, color: AppColors.bgPrimary,fontWeight: FontWeight.w600),),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        child: Padding(
                          padding: const EdgeInsets.all(7),
                          child: Column(
                                children: [
                                  regular.isNotEmpty ? Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text("Total Order", style: TextStyle(fontSize: 16, color: Colors.grey,fontWeight: FontWeight.w600),),
                                      Text("₹ $regTotal", style: const TextStyle(fontSize: 16, color: Colors.grey,fontWeight: FontWeight.w600),)
                                    ],
                                  ): const SizedBox(),
                                  subscription.isNotEmpty ? Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text("Total Subscription", style: TextStyle(fontSize: 16, color: Colors.grey,fontWeight: FontWeight.w600),),
                                      Text("₹ $subTotal", style: const TextStyle(fontSize: 16, color: Colors.grey,fontWeight: FontWeight.w600),)
                                    ],
                                  ):const SizedBox(),
                                  vproducts.isNotEmpty ? Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text("Total Subscription", style: TextStyle(fontSize: 16, color: Colors.grey,fontWeight: FontWeight.w600),),
                                      Text("₹ $pdtTotal", style: const TextStyle(fontSize: 16, color: Colors.grey,fontWeight: FontWeight.w600),)
                                    ],
                                  ):const SizedBox(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text("Total", style: TextStyle(fontSize: 16, color: Colors.grey,fontWeight: FontWeight.w600),),
                                      Text("₹ ${regTotal+subTotal+pdtTotal}", style: const TextStyle(fontSize: 16, color: Colors.grey,fontWeight: FontWeight.w600),)
                                    ],
                                  )
                                  ]
                              ),
                        ),
                            ),
                    ],
                  ),
                    ),
                  )
                        ],
                      );
                  } else{
                    // context.pop();
                    return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Something went wrong", style: TextStyle(fontSize: 14),),
                            Container(
                               decoration: BoxDecoration(
                                  color: const Color(0xFFFF8023), // Set your desired background color here
                                  borderRadius: BorderRadius.circular(100.0), // Optional: Add rounded corners
                                ),
                               width: 200,
                               height: 50,
                               margin: const EdgeInsets.all(10),
                               child: InkWell(
                                onTap: () => context.pop(),
                                  child: const Center(
                                    child: Text(
                                      "Go back",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                               ),
                             )
                          ],
                        ),
                      );
                  }
                } else {
                    return const Center(
                      child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.bgPrimary,),
                    );
                }
              }),
            ),
          );
  }
}

