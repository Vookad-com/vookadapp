import 'package:Vookad/components/nointernet.dart';
import 'package:Vookad/graphql/graphql.dart';
import 'package:Vookad/graphql/userquery.dart';
import 'package:flutter/material.dart';

import 'package:graphql_flutter/graphql_flutter.dart';

import '../components/otherCard.dart';

class Products extends StatefulWidget {
  const Products({super.key});

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {

Future fetchData() async {
  var query = QueryOptions(document: gql(monthly), variables: const {"family": "products"});
  final QueryResult result = await client.query(query);

  if (result.hasException) {
    print('Error: ${result.exception.toString()}');
    return [];
  } else {
    final Map<String, dynamic>? data = result.data;
    return data;
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _handleRefresh,
        child: FutureBuilder(
        future: fetchData(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            return SingleChildScrollView(
              child: Column(
                children: [
                  ClipRRect(
                     borderRadius: BorderRadius.circular(8.0),
                     child: const Image(
                             image:NetworkImage('https://firebasestorage.googleapis.com/v0/b/vookadweb.appspot.com/o/other%2Fproducts.png?alt=media&token=f388eb30-c462-4dde-ba3d-20a0c76fda33'),
                             fit: BoxFit.fitWidth,
                           ),
                   ),
                   const SizedBox(height: 15),
                  OFoods(dataList: (snapshot.data["inventoryItems"] as List)
                  .map((item) => item as Map<String, dynamic>)
                  .toList(),),
                  const SizedBox(height: 30),
                ],
              ),
            );
          } else if(snapshot.hasError){
            return const NoInternet();
          }
          else {
            return const Center(
              child: Text("Loading"),
            );
          }
        }
      ),
      ),
    );
  }
  Future<void> _handleRefresh() async {
    setState(() {

    });
  }
}
