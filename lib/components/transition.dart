import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

class Slide<T> extends CustomTransitionPage<T> {
  Slide({super.key, required super.child}) : super(
    transitionDuration: const Duration(milliseconds: 300),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return SlideTransition(
        position: Tween(begin: const Offset(0.0, 1.0), end: Offset.zero).animate(animation),
        child: child,
      );
    },
  );
}