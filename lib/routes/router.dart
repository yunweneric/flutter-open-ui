import 'package:flutter/material.dart';

class AppRouter {
  static navigate(BuildContext context, Widget page) async {
    return Navigator.of(context).push(_createRoute(page));
  }

  static Route _createRoute(Widget page) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 500),
      reverseTransitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }
}
