import 'package:flutter/material.dart';

class MontDetailsScreen extends StatefulWidget {
  const MontDetailsScreen({super.key});

  @override
  State<MontDetailsScreen> createState() => _MontDetailsScreenState();
}

class _MontDetailsScreenState extends State<MontDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        color: Colors.teal,
        height: 300,
        width: 300,
      ),
    );
  }
}
