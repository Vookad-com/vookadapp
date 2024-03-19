import 'package:Vookad/screens/address/map.dart';
import 'package:Vookad/screens/address/newadd.dart';
import 'package:Vookad/screens/checkout/cart.dart';
import 'package:Vookad/screens/checkout/placed.dart';
import 'package:Vookad/screens/profile/edit.dart';
import 'package:Vookad/screens/profile/order.dart';
import 'package:Vookad/screens/projects.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

import 'components/bottomNav.dart';


//transitions
import 'components/transition.dart';

// screens
import 'screens/home.dart';
import 'screens/schedule.dart';
import 'screens/profile.dart';
import 'screens/address/main.dart';
import 'screens/Coming.dart';
import 'screens/login.dart';
import 'screens/verify.dart';
import 'screens/Splash.dart';
import 'package:firebase_auth/firebase_auth.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _sectionHomeNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'sectionHomeNav');
final GlobalKey<NavigatorState> _sectionANavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'sectionANav');

FirebaseAuth? auth = FirebaseAuth.instance;

final GoRouter router = GoRouter(
      navigatorKey: _rootNavigatorKey,
      initialLocation: '/',
      routes: <RouteBase>[

        StatefulShellRoute.indexedStack(
          builder: (BuildContext context, GoRouterState state,
            StatefulNavigationShell navigationShell) {
          // Return the widget that implements the custom shell (in this case
          // using a BottomNavigationBar). The StatefulNavigationShell is passed
          // to be able access the state of the shell and to navigate to other
          // branches in a stateful way.
          return BottomNav(navigationShell: navigationShell);
        },
          branches: <StatefulShellBranch>[
              StatefulShellBranch(
                navigatorKey: _sectionHomeNavigatorKey,
                routes: <RouteBase>[
                  GoRoute(
                  path: '/home',
                  builder: (BuildContext context, GoRouterState state) {
                    return const Home();
                      },
                  redirect: (context, state) async {
                  // var auth = Hive.box('auth').get('jwt');
                  if (auth?.currentUser != null) {
                      return '/home';
                    } else {
                      return '/login';
                    }
                  },
                    ),
                  ],
                ),
              StatefulShellBranch(
                navigatorKey: _sectionANavigatorKey,
                routes: <RouteBase>[
                  GoRoute(
                    // The screen to display as the root in the first tab of the
                    // bottom navigation bar.
                    path: '/schedule',
                    builder: (BuildContext context, GoRouterState state) =>
                        const Schedule(),
                  ),
                ],
              ),
              StatefulShellBranch(
                routes: <RouteBase>[
                  GoRoute(
                    // The screen to display as the root in the first tab of the
                    // bottom navigation bar.
                    path: '/products',
                    builder: (BuildContext context, GoRouterState state) =>
                        const Products(),
                  ),
                ],
              ),
              StatefulShellBranch(
                routes: <RouteBase>[
                  GoRoute(
                    // The screen to display as the root in the first tab of the
                    // bottom navigation bar.
                    path: '/diet',
                    builder: (BuildContext context, GoRouterState state) =>
                        const Coming(),
                  ),
                ],
              ),
          ],
        ),
        GoRoute(
          path: '/profile',
          builder: (BuildContext context, GoRouterState state) {
            return const Profile();
          },
          parentNavigatorKey: _rootNavigatorKey
        ),
        GoRoute(
          path: '/profile/edit',
          builder: (BuildContext context, GoRouterState state) {
            return const Edit();
          },
          parentNavigatorKey: _rootNavigatorKey
        ),
        GoRoute(
          path: '/profile/orders',
          builder: (BuildContext context, GoRouterState state) {
            return const OrdersUI();
          },
          parentNavigatorKey: _rootNavigatorKey
        ),
        GoRoute(
          path: '/cart',
          builder: (BuildContext context, GoRouterState state) {
            return const Cart();
          },
          parentNavigatorKey: _rootNavigatorKey
        ),
        GoRoute(
          path: '/placed/:orderid',
          builder: (BuildContext context, GoRouterState state) {
            final orderid = state.pathParameters["orderid"]??"";
            return Placed(orderid: orderid);
          },
          parentNavigatorKey: _rootNavigatorKey
        ),
        GoRoute(
          path: '/address',
          pageBuilder: (BuildContext context, GoRouterState state) {
            return Slide<void>(
                key: state.pageKey,
                child: const Address(),
              );
          },
          parentNavigatorKey: _rootNavigatorKey
        ),
        GoRoute(
          path: '/address/map/:lng/:lat',
          builder: (BuildContext context, GoRouterState state) {
            final lng = double.tryParse(state.pathParameters["lng"]!)?? 0.0;
            final lat = double.tryParse(state.pathParameters["lat"]!)?? 0.0;
            return MapBox(lng: lng,lat: lat,);
          },
          parentNavigatorKey: _rootNavigatorKey
        ),
        GoRoute(
          path: '/address/setaddr/:lng/:lat/:id',
          builder: (BuildContext context, GoRouterState state) {
            final lng = double.tryParse(state.pathParameters["lng"]!)?? 0.0;
            final lat = double.tryParse(state.pathParameters["lat"]!)?? 0.0;
            final id = state.pathParameters["id"] ?? " ";
            return NewAddr(lng: lng,lat: lat,id: id);
          },
          parentNavigatorKey: _rootNavigatorKey
        ),
        GoRoute(
          path: '/login',
          builder: (BuildContext context, GoRouterState state) {
            return const Login();
          },
          parentNavigatorKey: _rootNavigatorKey
        ),
        GoRoute(
          path: '/',
          builder: (BuildContext context, GoRouterState state) {
            return const SplashScreen();
          },
          parentNavigatorKey: _rootNavigatorKey
        ),
        GoRoute(
          name: "verify",
          path: '/verify/:uid/:phone/:resend',
          builder: (BuildContext context, GoRouterState state) {
            final uid = state.pathParameters["uid"] ?? "";
            final phone = state.pathParameters["phone"] ?? "";
            final resendString = state.pathParameters["resend"];
            final int resend = resendString != null ? int.tryParse(resendString) ?? 0 : 0;
            return VerifyOtp(uid: uid, phone: phone, resend: resend);
          },
          parentNavigatorKey: _rootNavigatorKey
        ),
  ],
);

