import 'package:Vookad/graphql/graphql.dart';
import 'package:Vookad/models/pdtCat.dart';
import 'package:flutter/foundation.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';

class OrderCollection {
  late List<Order> orders;
  Map<String, dynamic> json;
  Set<String> nameRef;
  Set<String> chefRef;

  OrderCollection({
    required this.json,
    required this.nameRef,
    required this.chefRef,
  });
  
  fromGraph() async {
    orders = (json["fetchOrders"] as List<dynamic>).map((val) => Order.fromJson(val, nameRef, chefRef)).toList();
    await parsePdtnChef();
  }

  parsePdtnChef() async {
    String queryStr = """
      query ParseChefsnItems {
        ${
          chefRef.map((e) => 'chef$e : getchef(id: "$e") {displayname}').join("\n")
        }
        ${
          nameRef.map((e) => 'pdt$e : getItem(id: "$e") {name category {_id name price}}').join("\n")
        }
      }
    """;
    try {
      var query = QueryOptions(document: gql(queryStr));
      final QueryResult result = await client.query(query);
      if (result.hasException) {
        throw Exception('Graphql error');
      } else {
        for (int index = 0; index < orders.length; index++) {
          Order item = orders[index];
          for (OrderItem element in item.items) {
            List<PdtCat> cats = (result.data?['pdt${element.pdtid}']["category"] as List<dynamic>).map((e) {
              return PdtCat(price: e["price"].toDouble(), categoryId: e["_id"], name: e["name"]);
            }).toList();
            PdtCat cat = cats.firstWhere((i)=> i.categoryId == element.catid);
            element.pdt = cat;
            element.chefName = result.data?['chef${element.chefid}']["displayname"] ?? "";
            element.pdtName = result.data?['pdt${element.pdtid}']["name"] ?? "";
          }
        }
      }
    } catch(e){
      if (kDebugMode) {
        print(["error in try block", e]);
      }
    }
  }
}
class Order {
  String id;
  List<OrderItem> items;
  String status;
  String createdAt;
  int total;

  Order({
    required this.id,
    required this.items,
    required this.status,
    required this.createdAt,
    required this.total,
  });

  static String formatTimestamp(String? timestamp) {
    if(timestamp == null) {
      return "";
    }
    // Convert the timestamp to a DateTime object
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(int.parse(timestamp));

    // Format the DateTime using the desired pattern
    String formattedDateTime = DateFormat('dd/MM/yy HH:mm').format(dateTime);

    return formattedDateTime;
  }

  factory Order.fromJson(Map<String, dynamic> json, Set<String> nameRef, Set<String> chefRef) {
    return Order(
      id: json['_id'],
      items: (json['items'] as List<dynamic>)
          .map((item){
            OrderItem inst = OrderItem.fromJson(item);
            nameRef.add(inst.pdtid);
            chefRef.add(inst.chefid);
            return inst;
      })
          .toList(),
      status: json['status'],
      createdAt: formatTimestamp(json['createdAt']),
      total: json['total'],
    );
  }
}

class OrderItem {
  String catid;
  String chefid;
  String chefName;
  String pdtName;
  String pdtid;
  late PdtCat pdt;
  int quantity;

  OrderItem({
    required this.catid,
    required this.chefid,
    required this.pdtid,
    required this.quantity,
    this.chefName = '',
    this.pdtName = '',
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      catid: json['catid'],
      chefid: json['chefid'],
      pdtid: json['pdtid'],
      quantity: json['quantity'],
    );
  }
}
