import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hive/hive.dart';

final authLink = AuthLink(
  getToken: () async {
    // Fetch the auth token from a secure storage location.
    final auth = Hive.box('auth');
    final token = auth.get('jwt');
    return token;
  },
);

final client = GraphQLClient(
  cache: GraphQLCache(),
  link: authLink.concat(HttpLink(
    // 'https://api.vookad.com/graphql',
    'http://192.168.0.106:5000/graphql'
    // 'http://api.vookad.veganzo.earth/graphql',
  )),
);