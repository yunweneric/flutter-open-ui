import 'package:flutter/material.dart';
import 'package:flutter_openui/screens/components/annotated_region.dart';
import 'package:flutter_openui/screens/data/pizza.dart';
import 'package:flutter_openui/utils/sizing.dart';

class ZoomScreen extends StatefulWidget {
  final Pizza activePizza;
  const ZoomScreen({super.key, required this.activePizza});

  @override
  State<ZoomScreen> createState() => _ZoomScreenState();
}

class _ZoomScreenState extends State<ZoomScreen> {
  bool popping = false;
  @override
  Widget build(BuildContext context) {
    return AppAnnotatedRegion(
      child: PopScope(
        canPop: false,
        child: Scaffold(
          body: Stack(
            children: [
              Hero(
                tag: widget.activePizza.index,
                child: Image.asset(
                  height: AppSizing.height(context),
                  width: AppSizing.width(context),
                  fit: BoxFit.cover,
                  "assets/images/pizza_${widget.activePizza.index}.png",
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: kToolbarHeight) + const EdgeInsets.only(left: 20),
                child: GestureDetector(
                  onTap: () async {
                    setState(() {
                      popping = true;
                    });
                    await Future.delayed(Duration(milliseconds: 400));
                    Navigator.pop(context, true);
                  },
                  child: AnimatedOpacity(
                    opacity: popping ? 0 : 1,
                    duration: const Duration(milliseconds: 500),
                    child: AnimatedScale(
                      duration: const Duration(milliseconds: 500),
                      scale: popping ? 0 : 1,
                      child: CircleAvatar(
                        radius: 25,
                        backgroundColor: Theme.of(context).primaryColorLight,
                        child: const Icon(Icons.arrow_back),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
