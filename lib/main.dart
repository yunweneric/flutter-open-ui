import 'package:eva_barmananger/routes/AppRoutes.dart';
import 'package:eva_barmananger/routes/onGeneratedRoute.dart';
import 'package:eva_barmananger/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: kscaffoldBgColor,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: AppRoutes.loginScreen,
      onGenerateRoute: (settings) => Routegenerator.generatedRoutes(settings, context),
    );
  }
}
