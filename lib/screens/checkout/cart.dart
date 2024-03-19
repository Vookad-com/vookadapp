import 'package:Vookad/components/cardHolder.dart';
import 'package:Vookad/components/dateselector.dart';
import 'package:Vookad/graphql/userquery.dart';
import 'package:Vookad/models/address.dart';
import 'package:Vookad/models/pdtCat.dart';
import 'package:Vookad/models/product.dart';
import 'package:Vookad/models/searchAddr.dart';
import 'package:Vookad/toaster.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:Vookad/graphql/graphql.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:toast/toast.dart';
import '../../config/colors.dart';
import '../../config/location.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {

  List<Map<String,dynamic>> regular = [];
  bool loading = false;
  List<Map<String,dynamic>> subscription = [];
  List<Map<String,dynamic>> vproducts = [];
  late AddressInst selectedType;
  late Future<List<double>> location;
  final box = Hive.box<SearchAddr>('searchAddrBox');
  late Future<List<AddressInst>> addresses = fetchAddress();
  double regTotal = 0;
  double subTotal = 0;
  double pdtTotal = 0;
  Future<bool>? data;
  @override
  void initState() {
    super.initState();
    data = getAllProducts(); // Initialize your Future or perform one-time setup here
    location = getLoco();
  }

  void cartHandler(String pdtId,String categoryId, String chefId,bool change,double price) async {
    final box = await Hive.openBox('products'); // Open a Hive box named 'products'.
    // Check if a product with the given pdtId and categoryId exists in the box.
    final pdt = box.values.firstWhere(
      (product, ) => product.pdtId == pdtId && product.categoryId == categoryId && product.chefId == chefId,
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

  Future<List<AddressInst>> fetchAddress() async {
        SearchAddr? addr = box.get('current');
        try {
          var query = QueryOptions(document: gql(getAddress));
          final QueryResult result = await client.query(query);
          if (result.hasException) {
            throw Exception('Graphql error');
          } else {
            List<AddressInst> addresses = [];
            if (result.data?["getUser"]["addresses"] != null && result.data?["getUser"]["addresses"] is List) {
              for (var item in result.data?["getUser"]["addresses"]) {
                AddressInst inst = AddressInst(id: item["_id"],label: item["label"][0], area: item["area"], building: item["building"], landmark: item["landmark"], location:item["location"]["coordinates"], pincode: item["pincode"]);
                addresses.add(inst);
                if(addr?.lng == inst.location[0] || result.data?["getUser"]["addresses"][0]["_id"] == inst.id){
                  selectedType = inst;
                }
              }
            }
            return addresses;
          }
        } catch(e){
          print(e);
          throw Exception("Error in fetching");
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
  ${products.map((e) => 'pdt${e.categoryId+e.chefId} : getInventoryItem(id: "${e.pdtId}", chefId: "${e.chefId}") {enable chefId info {_id name family category {name price _id} }  }').join("\n")}
  }""";
  try {
    var query = QueryOptions(document: gql(pdtsQuery));
    final QueryResult result = await client.query(query);
    if (result.hasException) {
      throw Exception('Graphql error');
    } else {
      for (int index = 0; index < products.length; index++) {
        Product item = products[index];
        List<PdtCat> cats = (result.data?['pdt${item.categoryId+item.chefId}']["info"]["category"] as List<dynamic>).map((e) {
          return PdtCat(price: e["price"].toDouble(), categoryId: e["_id"], name: e["name"]);
        }).toList();
        PdtCat cat = cats.firstWhere((element)=> element.categoryId == item.categoryId);
        Map<String,dynamic> pdt = {...result.data?['pdt${item.categoryId+item.chefId}'], "category": cat,"quantity": item.quantity};
        switch (pdt["info"]["family"][0]) {
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
  void _checkout(BuildContext context) async {
    setState(() {
      loading = true;
    });
    var items = Hive.box('products').values.cast<Product>().map((Product e) => {"chefid":e.chefId, "pdtid":e.pdtId,"catid":e.categoryId, "quantity":e.quantity}).toList();
    DateTime? dod = Hive.box('deliveryDate').get("current");
    var payload = {
      "items":items,
      "address":selectedType.toJson(),
      "total":regTotal+subTotal+pdtTotal,
      "dod": dod?.toIso8601String() ?? DateTime.now().toIso8601String()
    };
    try {
        var query = MutationOptions(document: gql(codcheckout), variables: payload);
        final QueryResult result = await client.mutate(query);
        if (result.hasException) {
          if (kDebugMode) {
            print(result.exception);
          }
          throw Exception('Graphql error');
        } else {
          await Hive.box('products').clear();
          await Hive.box('cart').clear();
          context.pop();
          context.push("/placed/${result.data?['codcheckout']['_id']}");
        }
      } catch(e){
        print(e);
        showtoast("Please try again later!");
      }
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return Scaffold(
            bottomNavigationBar: InkWell(
              onTap: () => _checkout(context),
              child: Container(
              margin: const EdgeInsets.all(6),
              alignment: Alignment.center,
              height: 50,
              decoration: BoxDecoration(
                color: AppColors.bgPrimary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Pay ₹ ${regTotal+subTotal+pdtTotal}", style: const TextStyle(color: AppColors.white, fontSize: 18, fontWeight: FontWeight.w600),),
                  loading  ? const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: CircularProgressIndicator(
                      strokeWidth: 3.0,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : const SizedBox()
                ],
              ),
            ),
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
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                            child: const Text("Date of Delivery", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),),
                          ),
                          const DateSelector(),
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
                  ),
           Container(
              margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
              child: const Text("Mode of payement", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),),
            ),
            Column(
              children: [
                Row(
                children: [
                  Radio(
                    value:"cash on delivery",
                    groupValue: "cash on delivery",
                    onChanged: (val){

                    },
                  ),
                  const Text("Pay on delivery")
                ],
              )
              ],
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
              child: const Text("Select Address", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),),
            ),
            FutureBuilder(
                future: addresses,
                builder: (context, snapshot){
                  if(snapshot.hasData){
                    return Padding(padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: snapshot.data!.map((e){
                          return Row(
                            children: [
                              Radio(
                                value: e,
                                groupValue: selectedType,
                                onChanged: (value) {
                                  setState(() {
                                    selectedType = e;
                                  });
                                },
                              ),
                              Column(
                                children: [
                                  const Icon(Icons.place, color: AppColors.bgPrimary,),
                                  Text(e.label),
                                ],
                              ),
                              const SizedBox(width: 10,),
                              Expanded(child: Text("${e.building}, ${e.area}, ${e.landmark}", style: const TextStyle(fontSize: 14),overflow: TextOverflow.ellipsis,
                                maxLines: 1,))
                            ],
                          );
                        } ).toList(),
                      ),
                    );
                  }
                  if(snapshot.hasError){
                    return const SizedBox();
                  }
                  return Container(
                    width: 20,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    height:20,
                    child:const CircularProgressIndicator(strokeWidth: 1,color: AppColors.bgPrimary),
                  );
                }
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
              padding: const EdgeInsets.symmetric(vertical: 5.0),// Vertical margin
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12.0),
                ),
              child: InkWell(
                onTap: () async {
                  List<double> loco = await location;
                  context.push("/address/setaddr/${loco[1]}/${loco[0]}/ ");
                },
                child: const Padding(
                  padding: EdgeInsets.all(5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.add, color: AppColors.bgPrimary,),
                          SizedBox(width: 10,),
                          Text("Add Address", style: TextStyle(fontSize: 14),)
                        ],
                      ),
                      Icon(Icons.arrow_right_rounded)
                    ],
                  ),
                ),
              ),
            ),
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

