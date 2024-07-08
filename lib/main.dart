import 'package:flutter/material.dart';
import 'package:flutter_open_animate/pages/home.dart';
import 'package:flutter_open_animate/utils/theme.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppTheme(),
      child: Consumer<AppTheme>(
        builder: (context, theme, child) {
          return MaterialApp(
            title: 'Animated Dark',
            debugShowCheckedModeBanner: false,
            theme: theme.currentTheme,
            // darkTheme: AppTheme.dark(),
            home: const HomePage(),
          );
        },
      ),
    );
  }
}
