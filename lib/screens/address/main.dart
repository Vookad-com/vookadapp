import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:graphql_flutter/graphql_flutter.dart';
import '../../graphql/graphql.dart';
import '../../graphql/userquery.dart';

class Address extends StatefulWidget {
  const Address({super.key});

  @override
  State<Address> createState() => _AddressState();
}

class _AddressState extends State<Address> {
  @override
  Future<void> fetchAddress() async {
        try {
          var query = QueryOptions(document: gql(getAddress));
          final QueryResult result = await client.query(query).timeout(const Duration(seconds: 30));
          if (result.hasException) {
            throw Exception('Graphql error');
          } else {
            print(result.data?["getAddresses"]);
          }
        } catch(e){
          print("error");
        }
      }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(
          children: <Widget>[
            const SizedBox(width: 10, height: 5,),
            Row(
              children: [
                InkWell(
                  onTap: () {
                      context.pop();
                    },
                  child: const Icon(Icons.keyboard_arrow_down),
                ),
                const SizedBox(width: 10),
                const Text('Select a location', style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,),)
              ],
            ),
          ],
        )
        ),
    );
  }
}
