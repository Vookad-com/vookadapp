import 'package:Vookad/graphql/graphql.dart';
import 'package:Vookad/graphql/userquery.dart';
import 'package:flutter/material.dart';
import '../components/foodCards.dart';

import 'package:graphql_flutter/graphql_flutter.dart';

import '../components/otherCard.dart';

class Schedule extends StatefulWidget {
  const Schedule({super.key});

  @override
  State<Schedule> createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {

Future fetchData() async {
  var query = QueryOptions(document: gql(monthly), variables: const {"family": "package"});
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
                             image:NetworkImage('https://firebasestorage.googleapis.com/v0/b/vookadweb.appspot.com/o/other%2Fsubscribe.png?alt=media&token=ee94a93a-1498-4b05-9671-63df4ca774e1&_gl=1*7qpo3h*_ga*MzMzNzM4MTMxLjE2OTc4MDE0OTg.*_ga_CW55HF8NVT*MTY5ODY1MTExNi42LjEuMTY5ODY1MTg3NC4zNi4wLjA.'),
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
