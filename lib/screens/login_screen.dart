import 'package:flutter/material.dart';
import 'package:kalio/utils/colors.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kgreen,
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/images/logo.png'),
                const Text("Enter your mobile number"),
                const Text("You will receive a 4 digit code to verify next")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
