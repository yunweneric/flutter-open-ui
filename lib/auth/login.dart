import 'package:auth_02/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

bool _showPassword = false;

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String helpertext = '';
  String username = '';
  String email = '';
  String password = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.0.w, vertical: 20.0.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 50.h,
              ),
              Container(
                child: Text(
                  "Let's get you sign in!",
                  style: kheading1,
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Container(
                child: Text(
                  "Welcome back. \nYou've been missed!",
                  style: kheading2,
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(
                height: 50.0.h,
              ),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 15.0.h),
                  hintStyle: kplaceholder,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0.r),
                    borderSide: BorderSide(
                      color: kdarkcolor,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0.r),
                    borderSide: BorderSide(
                      color: kdarkcolor,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0.r),
                    borderSide: BorderSide(
                      color: Colors.teal,
                    ),
                  ),
                  hintText: "Email or Username",
                ),
              ),
              SizedBox(height: 20.0.h),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 15.0.h),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0.r),
                    borderSide: BorderSide(
                      color: kwhite,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0.r),
                    borderSide: BorderSide(
                      color: Colors.teal,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0.r),
                    borderSide: BorderSide(
                      color: Colors.teal,
                    ),
                  ),
                  helperText: "$helpertext",
                  hintText: "Password",
                  hintStyle: kplaceholder,
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        _showPassword = !_showPassword;
                      });
                    },
                    child: Icon(
                      _showPassword ? Icons.visibility : Icons.visibility_off,
                      size: 20,
                      color: kwhite,
                    ),
                  ),
                ),
                obscureText: !_showPassword,
              ),
              SizedBox(height: 15.0.h),
              Spacer(),
              GestureDetector(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account? "),
                      Text(
                        "Register",
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.0.h),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(color: Colors.transparent, borderRadius: BorderRadius.circular(10)),
                child: ElevatedButton(
                    onPressed: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
                      child: Text(
                        'Sign in',
                        style: TextStyle(color: kdarkcolor, fontSize: 16.0),
                        textAlign: TextAlign.right,
                      ),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFFFFFFF)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0), side: BorderSide(color: Colors.transparent))),
                    )),
              ),              SizedBox(height: 30.h,)

            ],
          ),
        ),
      ),
    );
  }
}
