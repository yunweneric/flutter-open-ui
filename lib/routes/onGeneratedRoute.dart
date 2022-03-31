import 'package:eva_barmananger/screens/HomePage.dart';
import 'package:eva_barmananger/screens/MainPage.dart';
import 'package:eva_barmananger/screens/auth/login.dart';
import 'package:eva_barmananger/screens/auth/signUp.dart';

import 'AppRoutes.dart';
import 'package:flutter/material.dart';

class Routegenerator {
  static Route<dynamic> generatedRoutes(RouteSettings settings, context) {
    final args = settings.arguments;
    switch (settings.name) {
      case (AppRoutes.loginScreen):
        return MaterialPageRoute(builder: (context) => LoginScreen());

      case (AppRoutes.createAccount):
        return MaterialPageRoute(builder: (context) => SignUp());

      case (AppRoutes.mainPage):
        return MaterialPageRoute(builder: (context) => MainPage());

      case (AppRoutes.homeScreen):
        return MaterialPageRoute(builder: (context) => HomePage());

      default:
        return MaterialPageRoute(builder: (context) => LoginScreen());
    }
  }
}
