import 'package:Vookad/components/orderCell.dart';
import 'package:Vookad/config/colors.dart';
import 'package:Vookad/graphql/graphql.dart';
import 'package:Vookad/graphql/userquery.dart';
import 'package:Vookad/models/orders.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class OrdersUI extends StatefulWidget {
  const OrdersUI({super.key});

  @override
  State<OrdersUI> createState() => _OrdersState();
}

class _OrdersState extends State<OrdersUI> {

  final ScrollController _scrollController = ScrollController();
  bool loading = true;
  int page = 0;
  List<Order> orders = [];
  late Future<OrderCollection> response;
  Future<OrderCollection> loadOrders()async{
    var query = QueryOptions(document: gql(getOrders), variables: {"page":++page});
    final QueryResult result = await client.query(query);
    if (result.hasException) {
      if (kDebugMode) {
        print('Error: ${result.exception.toString()}');
      }
      throw Exception(result.exception.toString());
    } else {
      OrderCollection resp = OrderCollection(json: result.data ?? {},nameRef: {}, chefRef: {});
      await resp.fromGraph();
      return resp;
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    response = loadOrders();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() async {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      // You have reached the end of the scroll, trigger your pagination callback here
      Future<OrderCollection> resp = loadOrders();
      resp.then((OrderCollection result){
        setState(() {
          orders.addAll(result.orders);
        });
      }).catchError((err){
        if (kDebugMode) {
          print(err);
        }
      });
      
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF6FBFF),
      body: SafeArea(child: ListView(
        controller: _scrollController,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            child: const Text("Order History"
            ,style: TextStyle(fontSize: 22,fontWeight: FontWeight.w700,color: AppColors.bgPrimary),),
          ),
          FutureBuilder(future: response, builder: (context, snapshot) {
            if(snapshot.hasData){
              if(page == 1){
                orders.addAll(snapshot.data?.orders ?? []);
              }
              if(orders.length == 0){
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      "You haven't order anything yet 🥲",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                );
              }
              return Column(
              children: orders.map((e) => OrderCell(order: e)).toList(),
            );

            }
            return const Stack(
            children: [
              Center(
            child: CircularProgressIndicator(color: AppColors.bgPrimary,),
          )
            ],
          );
          }),
        ],
      )),
    );
  }
}
