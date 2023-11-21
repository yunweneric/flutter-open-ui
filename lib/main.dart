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
            Positioned(
              top: 20,
              left: 20,
              right: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  currentIndex > 0
                      ? GestureDetector(
                          onTap: () {
                            if (currentIndex > 0) controller.animateToPage(currentIndex - 1, duration: const Duration(milliseconds: 500), curve: Curves.linear);
                          },
                          child: const Icon(Icons.arrow_back_outlined, size: 30),
                        )
                      : const SizedBox.shrink(),
                  Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: () {
                        controller.animateToPage(data.length - 1, duration: const Duration(milliseconds: 500), curve: Curves.linear);
                      },
                      child: const Text("Skip", style: TextStyle(fontWeight: FontWeight.w500)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          indicator(i == 0),
                          indicator(i == 1),
                          indicator(i == 2),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          if (i < 2) controller.animateToPage(i + 1, duration: Duration(milliseconds: 500), curve: Curves.linear);
                          // setState(() {
                          //   if (i < 2) i = i++;
                          // });
                        },
                        child: const CircleAvatar(
                          radius: 25,
                          backgroundColor: Color(0XFF02CA92),
                          child: Icon(Icons.arrow_right_alt, size: 30, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
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

  Container indicator(bool isActive) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      height: isActive ? 8 : 10,
      width: isActive ? 40 : 10,
      decoration: BoxDecoration(
        color: Color(0XFF02CA92),
        borderRadius: isActive ? BorderRadius.circular(10) : null,
        shape: isActive ? BoxShape.rectangle : BoxShape.circle,
      ),
    );
  }
}

class ScreenData {
  final String title;
  final String description;

  ScreenData({required this.title, required this.description});
}
