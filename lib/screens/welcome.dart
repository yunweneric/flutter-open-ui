import 'package:auth_02/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/constants.dart';

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.0.w),
          child: Column(
            children: [
              Image(
                image: AssetImage("assets/images/Build.png"),
              ),
              SizedBox(
                height: 50.h,
              ),
              Container(
                child: Text(
                  'Enterprise team collaboration.',
                  style: kheading1,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 50.h,
              ),
              Container(
                child: Text(
                  'Bring together your files, your tools projects and people, including a new mobile and desktop application',
                  style: kpara,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 30.0.h,
              ),
              Spacer(),
              Container(
                  width: double.infinity,
                  decoration: BoxDecoration(color: Colors.transparent, borderRadius: BorderRadius.circular(10)),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Login(),
                              ),
                            );
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 35.0.w, vertical: 18.0.h),
                            child: Text(
                              'Sign in',
                              textAlign: TextAlign.right,
                            ),
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF3A3941)),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20.r),
                                  bottomRight: Radius.circular(20.r),
                                ),
                                side: BorderSide(color: Colors.transparent))),
                          ),
                        ),
                        left: 140.0.w,
                        top: 0,
                      ),
                      Positioned(
                        // width: 100.0,
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Login(),
                                ),
                              );
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 35.0.w, vertical: 18.0.h),
                              child: Text(
                                "Register",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0.r),
                                  side: BorderSide(color: Colors.transparent))),
                            )),
                      )
                      // top: 0,
                    ],
                  )),
              SizedBox(height: 30.h,)
            ],
          ),
        ),
      ),
    );
  }
}
