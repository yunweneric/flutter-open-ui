import 'package:flutter/material.dart';
import 'package:flutter_openui/utils/sizing.dart';

class ToggleOption {
  final String title;
  final IconData icon;

  ToggleOption({required this.title, required this.icon});
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  bool isVisible = false;
  List<ToggleOption> options = [
    ToggleOption(title: "Contents - 18%", icon: Icons.menu),
    ToggleOption(title: "Bookmarks & Highlights", icon: Icons.thirty_fps_outlined),
    ToggleOption(title: "Search Book", icon: Icons.search),
    ToggleOption(title: "Theme & Settings", icon: Icons.settings),
    ToggleOption(title: "", icon: Icons.settings),
  ];

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void toggleAnimation(BuildContext context, {bool? status}) {
    status == false ? controller.reverse() : controller.forward();
    setState(() {
      isVisible = status ?? !isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        colorScheme: const ColorScheme.dark(primary: Colors.white),
        primaryColorLight: Colors.white,
        scaffoldBackgroundColor: const Color(0xFF000000),
        iconTheme: const IconThemeData(color: Colors.white),
        primaryColor: const Color(0xFF3F4041),
        chipTheme: ChipThemeData(
          backgroundColor: const Color(0xFF3F4041),
          side: BorderSide.none,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
      child: Builder(builder: (context) {
        final theme = Theme.of(context);
        return Scaffold(
          floatingActionButton: AnimatedOpacity(
            opacity: isVisible ? 0.0 : 1.0,
            curve: isVisible ? Curves.fastEaseInToSlowEaseOut : Curves.easeIn,
            duration: const Duration(milliseconds: 700),
            child: AnimatedScale(
              curve: isVisible ? Curves.fastEaseInToSlowEaseOut : Curves.easeIn,
              scale: isVisible ? 0.0 : 1.0,
              duration: const Duration(milliseconds: 700),
              child: FloatingActionButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                onPressed: () => toggleAnimation(context),
                child: const Icon(Icons.menu),
              ),
            ),
          ),
          body: SafeArea(
            child: GestureDetector(
              onTap: () => toggleAnimation(context, status: false),
              child: Stack(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: AppSizing.width(context) * 0.08),
                    color: theme.scaffoldBackgroundColor,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          AppSizing.k20(context),
                          RichText(
                            text: const TextSpan(
                              children: [
                                TextSpan(
                                  text: "The Journey of Flutura",
                                  style: TextStyle(fontSize: 22, height: 2.5),
                                ),
                                TextSpan(
                                  text:
                                      "\nIn a quiet little town tucked amidst misty hills, there lived a young programmer named Kai. Though Kai was an adept coder, they felt constrained by the technology they used. Everything seemed overly complicated, fragmented, and, at times, soulless. Kai longed to create something beautiful, something that danced in people’s lives like a butterfly in a garden.",
                                  style: TextStyle(fontSize: 16, height: 1.5),
                                ),
                                TextSpan(
                                  text: "\nA New Beginning",
                                  style: TextStyle(fontSize: 22, height: 2.5),
                                ),
                                TextSpan(
                                  text:
                                      "\nThe next day, Kai dived into Flutter, guided by its companion language, Dart. The syntax felt like a friendly invitation. Unlike some of the verbose languages they had used, Dart was clean, concise, and intuitive.",
                                  style: TextStyle(fontSize: 16, height: 1.5),
                                ),
                                TextSpan(
                                  text: "\n“Hello, world,” Kai typed eagerly, following the Flutter documentation. Within moments, a sleek app emerged on the emulator—a polished screen with a single centered text: Hello, Flutter!",
                                  style: TextStyle(fontSize: 16, height: 1.5),
                                ),
                                TextSpan(
                                  text:
                                      "\nAs the days turned into weeks, Kai’s skills blossomed. Flutter’s hot reload became their favorite tool—an almost magical ability to see changes instantly, like a painter watching their strokes come alive on the canvas.",
                                  style: TextStyle(fontSize: 16, height: 1.5),
                                ),
                                TextSpan(
                                  text: "\nMeeting Flutura",
                                  style: TextStyle(fontSize: 22, height: 2.5),
                                ),
                                TextSpan(
                                  text:
                                      "\nOne late evening, surrounded by empty coffee mugs and glowing screens, Kai began a new project: an app to help local farmers track their crops and predict harvest yields. They named the app Flutura, inspired by the Albanian word for butterfly.",
                                  style: TextStyle(fontSize: 16, height: 1.5),
                                ),
                                TextSpan(
                                  text:
                                      "\nThe app needed to feel alive, so Kai ventured into Flutter’s animation library. They crafted elegant transitions between screens, buttons that gently pulsed when tapped, and cards that flipped like turning pages. With Dart’s type safety and powerful tooling, debugging was a breeze.",
                                  style: TextStyle(fontSize: 16, height: 1.5),
                                ),
                                TextSpan(
                                  text:
                                      "\nAs the days turned into weeks, Kai’s skills blossomed. Flutter’s hot reload became their favorite tool—an almost magical ability to see changes instantly, like a painter watching their strokes come alive on the canvas.",
                                  style: TextStyle(fontSize: 16, height: 1.5),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  AnimatedBuilder(
                      animation: controller,
                      builder: (context, child) {
                        final items = options.reversed.toList();
                        return Stack(
                          children: [
                            ...List.generate(items.length, (i) {
                              final animation = Tween<double>(begin: 0, end: 1).animate(
                                CurvedAnimation(
                                  parent: controller,
                                  curve: Interval(
                                    0.0 * (1 - (i / items.length)),
                                    1.0 * (1 - (i / items.length)),
                                    curve: Curves.fastEaseInToSlowEaseOut,
                                  ),
                                ),
                              );
                              final option = items[i];
                              return Positioned(
                                bottom: AppSizing.height(context) * animation.value * 0.06 * i + kBottomNavigationBarHeight * 0.5,
                                right: AppSizing.width(context) * 0.08 * animation.value,
                                child: Transform.scale(
                                  alignment: Alignment.bottomRight,
                                  scale: animation.value,
                                  child: i == 0
                                      ? SizedBox(
                                          width: AppSizing.width(context) * 0.6,
                                          child: const Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Chip(label: Icon(Icons.ios_share_outlined)),
                                              Chip(label: Icon(Icons.camera_alt_outlined)),
                                              Chip(label: Icon(Icons.ios_share_outlined)),
                                              Chip(label: Icon(Icons.bookmark_border_outlined)),
                                            ],
                                          ),
                                        )
                                      : AppButton(
                                          onPressed: () {},
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(option.title),
                                              Icon(option.icon),
                                            ],
                                          ),
                                        ),
                                ),
                              );
                            }),
                          ],
                        );
                      }),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

class AppButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;
  const AppButton({super.key, required this.child, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: theme.primaryColor,
        minimumSize: Size(AppSizing.width(context) * 0.6, 45),
        maximumSize: Size(AppSizing.width(context) * 0.6, 45),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: onPressed,
      child: child,
    );
  }
}
