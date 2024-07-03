import 'package:flutter/material.dart';

class UtilHelper {
  static navigate({required BuildContext context, required Widget page}) {
    return Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 700),
        reverseTransitionDuration: Duration(milliseconds: 700),
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    );
  }
}
