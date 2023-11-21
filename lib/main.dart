import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_openui/utils/image_assets.dart';
import 'package:flutter_openui/utils/sizing.dart';
import 'package:flutter_svg/svg.dart';
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
  @override
  void didChangeDependencies() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        systemNavigationBarColor: Color(0XFFF4F5F0),
        statusBarColor: Color(0XFFF4F5F0),
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark,
      ));
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // primarySwatch: Colors.teal,
        primaryColor: const Color(0xFF02CA92),
        scaffoldBackgroundColor: const Color(0XFFF4F5F0),
        textTheme: TextTheme(
          displayLarge: GoogleFonts.poppins(fontSize: 32.0, fontWeight: FontWeight.w600, color: const Color(0xFF4A4848)),
          bodyMedium: GoogleFonts.poppins(fontSize: 18.0, fontWeight: FontWeight.w300),
        ),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  PageController controller = PageController(initialPage: 0);
  int currentIndex = 0;
  List<ScreenData> data = [
    ScreenData(title: "Buy tickets", description: "Get your tickets with easy and have access to your e-ticket anywhere,anytime."),
    ScreenData(title: "Schedule Info", description: "Know your schedule and ticket update ahead."),
    ScreenData(title: "Track your location", description: "Track and share your location with family and friends via text or whatsapp.")
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            appPage(context),
            topNavigation(),
            bottomNavigation(),
          ],
        ),
      ),
    );
  }

  Positioned bottomNavigation() {
    return Positioned(
      bottom: 20,
      left: 30,
      right: 30,
      child: SizedBox(
        height: 40,
        width: kWidth(context),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                indicator(currentIndex == 0),
                indicator(currentIndex == 1),
                indicator(currentIndex == 2),
              ],
            ),
            GestureDetector(
              onTap: () {
                if (currentIndex < 2) controller.animateToPage(currentIndex + 1, duration: Duration(milliseconds: 500), curve: Curves.linear);
              },
              child: const CircleAvatar(
                radius: 25,
                backgroundColor: Color(0XFF02CA92),
                child: Icon(Icons.arrow_right_alt, size: 30, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Positioned topNavigation() {
    return Positioned(
      top: 20,
      left: 20,
      right: 20,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AnimatedSwitcher(
            duration: Duration(milliseconds: 900),
            child: currentIndex > 0
                ? GestureDetector(
                    onTap: () {
                      if (currentIndex > 0) controller.animateToPage(currentIndex - 1, duration: const Duration(milliseconds: 500), curve: Curves.linear);
                    },
                    child: const Icon(Icons.arrow_back_outlined, size: 30),
                  )
                : const SizedBox(height: 10),
          ),
          Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: () {
                controller.animateToPage(data.length - 1, duration: const Duration(milliseconds: 500), curve: Curves.linear);
              },
              child: const Text("Skip", style: TextStyle(fontWeight: FontWeight.w600)),
            ),
          ),
        ],
      ),
    );
  }

  PageView appPage(BuildContext context) {
    return PageView.builder(
      controller: controller,
      itemCount: data.length,
      onPageChanged: (index) {
        setState(() {
          currentIndex = index;
        });
      },
      itemBuilder: (c, i) {
        ScreenData item = data[i];
        return Column(
          children: [
            Column(
              children: [
                kh20Spacer(),
                kh20Spacer(),
                Image.asset(
                  ImageAsset.illustration + "${i}.png",
                  width: kWidth(context),
                ),
              ],
            ),
            const Spacer(),
            Container(
              padding: kPadding(30, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.title, style: Theme.of(context).textTheme.displayLarge),
                  kh10Spacer(),
                  Text(
                    item.description,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  kh20Spacer(),
                  kh20Spacer(),
                  kh20Spacer(),
                  kh20Spacer(),
                ],
              ),
            )
          ],
        );
      },
    );
  }

  Widget indicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      margin: const EdgeInsets.only(right: 10),
      height: isActive ? 8 : 10,
      width: isActive ? 40 : 10,
      decoration: BoxDecoration(
        color: const Color(0XFF02CA92),
        borderRadius: isActive ? BorderRadius.circular(10) : BorderRadius.circular(10),
        // shape: isActive ? BoxShape.rectangle : BoxShape.circle,
      ),
    );
  }
}

class ScreenData {
  final String title;
  final String description;

  ScreenData({required this.title, required this.description});
}
