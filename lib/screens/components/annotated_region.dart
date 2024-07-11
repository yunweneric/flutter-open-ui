import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppAnnotatedRegion extends StatefulWidget {
  final Widget child;
  const AppAnnotatedRegion({super.key, required this.child});

  @override
  State<AppAnnotatedRegion> createState() => _AppAnnotatedRegionState();
}

class _AppAnnotatedRegionState extends State<AppAnnotatedRegion> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Theme.of(context).primaryColorLight,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: widget.child,
    );
  }
}
