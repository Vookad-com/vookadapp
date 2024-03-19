import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';

AuthLink authLink = AuthLink(
  getToken: () async {
    // Fetch the auth token from a secure storage location.
    // final auth = Hive.box('auth');
    // final token = auth.get('jwt');
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      final token = await user.getIdToken();
      return token;
    }

    return "";
  },
);


GraphQLClient client = GraphQLClient(
    cache: GraphQLCache(),
    link: authLink.concat(HttpLink(
      'https://vookadbackend-sntvot5t7q-uc.a.run.app/graphql',
      // 'http://192.168.13.63:5000/graphql',
      // 'http://82.83.84.56:5000/graphql',
    )),
  );