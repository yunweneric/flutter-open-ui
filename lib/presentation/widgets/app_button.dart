import 'package:flutter/material.dart';

class AppButton extends StatefulWidget {
  final Widget icon;
  final String text;
  const AppButton({super.key, required this.icon, required this.text});

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: widget.icon,
      label: Text(widget.text),
    );
  }
}
