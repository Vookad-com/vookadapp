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
    'http://192.168.0.105:3000/graphql',
    // 'https://api-vookad.onrender.com',
  )),
);