import 'package:auth_02/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:kalio/screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Color(0xFF191720),
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Color(0xFF191720),
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );

    return ScreenUtilInit(
        designSize: Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: () {
          return MaterialApp(
            builder: (context, widget) {
              //add this line
              ScreenUtil.setContext(context);
              return MediaQuery(
                //Setting font does not change with system font size
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: widget!,
              );
            },
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            themeMode: ThemeMode.system,
            theme: ThemeData.dark().copyWith(
              scaffoldBackgroundColor: kdarkcolor,
              bottomAppBarColor: Color(0xFF1A2634),
              floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: Colors.teal),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(selectedItemColor: Color(0xFF1A2634)),
              dialogBackgroundColor: Colors.teal,
            ),
            home: LoginScreen(),
          );
        });
  }
}
