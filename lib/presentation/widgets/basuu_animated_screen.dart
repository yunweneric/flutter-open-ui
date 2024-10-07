import 'package:flutter/material.dart';

class BasuuAnimatedScreen extends StatefulWidget {
  final bool? animated;
  final Widget Function(BuildContext context, bool animated, double animation) builder;
  const BasuuAnimatedScreen({super.key, this.animated, required this.builder});

  @override
  State<BasuuAnimatedScreen> createState() => _AnimatedScreenState();
}

class _AnimatedScreenState extends State<BasuuAnimatedScreen> {
  bool animated = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((d) {
      setState(() => animated = widget.animated ?? true);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (pop) {
        setState(() => animated = false);
      },
      child: TweenAnimationBuilder(
        tween: animated ? Tween<double>(begin: 1, end: 0) : Tween<double>(begin: 0, end: 1),
        curve: Curves.fastOutSlowIn,
        key: ValueKey(animated),
        duration: const Duration(milliseconds: 700),
        builder: (context, animation, _) {
          return widget.builder(context, animated, animation);
        },
      ),
    );
  }
}
