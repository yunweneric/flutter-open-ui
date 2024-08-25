import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_openui/data/controllers/bloc/navigation_bloc.dart';
import 'package:flutter_openui/screens/home_screen.dart';
import 'package:flutter_openui/utils/colors.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  final navBloc = NavigationBloc();

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: navBloc,
      child: BlocBuilder<NavigationBloc, NavigationState>(
        bloc: navBloc,
        builder: (context, state) {
          print(["updating"]);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Wallet App',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryBlue),
              useMaterial3: true,
              scaffoldBackgroundColor: AppColors.primaryBlue,
              primaryColorLight: AppColors.textWhite,
              primaryColorDark: AppColors.textBlack,
              listTileTheme: ListTileThemeData(
                titleTextStyle: GoogleFonts.inter(
                  fontSize: 20,
                  color: AppColors.textWhite,
                  fontWeight: FontWeight.w500,
                ),
                subtitleTextStyle: GoogleFonts.inter(
                  fontSize: 15,
                  color: AppColors.blueLight,
                  fontWeight: FontWeight.w500,
                ),
              ),
              textTheme: TextTheme(
                displayLarge: GoogleFonts.inter(
                  fontSize: 40,
                  color: AppColors.textWhite,
                  fontWeight: FontWeight.bold,
                ),
                displayMedium: GoogleFonts.inter(
                  fontSize: 30,
                  color: AppColors.blueLight,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            home: HomeScreen(),
          );
        },
      ),
    );
  }
}
