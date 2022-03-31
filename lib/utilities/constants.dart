import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Theme color
const Color kprimaryColor = Color(0xFF003D95);
const Color kbluecover = Color(0x77003D95);
const Color kbluecover2 = Color(0x33003D95);
const Color kscaffoldBgColor = Color(0xFFf7f7f7);
const Color ktextGrey = Color(0xFF323232);
const Color kOrange = Color(0xFFF79623);
const Color kactiveTextColor = Color(0xff3AB19B);
const Color kprimaryRed = Color(0xffEB5757);

const ksubtitle = TextStyle(
    fontSize: 25.0, color: kprimaryColor, fontWeight: FontWeight.w500);

const kmainpadding =
    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0);

// Text Style
const kHeadingTextStyle = TextStyle(
  fontSize: 22,
  fontWeight: FontWeight.w600,
);

const kboldTextProfile = TextStyle(
  color: Colors.black,
  fontSize: 14.0,
  fontWeight: FontWeight.w700,
);
//--------------------------- screen height & width ----------------------------

SizedBox majorSpacer(BuildContext context) {
  return SizedBox(
    height: screenHeight(context) / 20,
  );
}

SizedBox minorSpacer(BuildContext context) {
  return SizedBox(
    height: screenHeight(context) / 40,
  );
}

double screenHeight(context) {
  return MediaQuery.of(context).size.height;
}

double screenWidth(context) {
  return MediaQuery.of(context).size.width;
}

saveAllUserInfo(String userInfo) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.setString('user_info', userInfo);
}

saveUserSessionKey(session_key) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.setString('session_key', session_key);
}

getUserSessionKey() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  return sharedPreferences.getString("session_key");
}

getEveryGlobalInfo(String key) async {
  print("This is key : $key");
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  if (sharedPreferences.getString(key) == null ||
      sharedPreferences.getString(key) == "") {
    return null;
  } else {
    // return json.decode(sharedPreferences.getString(key));
  }
}

showInfoDialog(context, msg) {
  AwesomeDialog(
      dismissOnTouchOutside: false,
      context: context,
      animType: AnimType.SCALE,
      dialogType: DialogType.NO_HEADER,
      body: Center(
        child: Text(
          msg,
          style: TextStyle(
              fontStyle: FontStyle.normal, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
      btnOkOnPress: () async {},
      btnOkColor: Colors.blue)
    ..show();
}

showToastSuccess(String msg) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0);
}

showToastInfo(String msg) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.lightBlue,
      textColor: Colors.white,
      fontSize: 16.0);
}

showToastError(String msg) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0);
}

bool isPasswordCompliant(String password, [int minLength = 6]) {
  if (password == null || password.isEmpty) {
    return false;
  }

  bool hasUppercase = password.contains(new RegExp(r'[A-Z]'));
  bool hasDigits = password.contains(new RegExp(r'[0-9]'));
  bool hasLowercase = password.contains(new RegExp(r'[a-z]'));
  bool hasSpecialCharacters =
      password.contains(new RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
  bool hasMinLength = password.length > minLength;

  return hasDigits &
      hasUppercase &
      hasLowercase &
      hasSpecialCharacters &
      hasMinLength;
}
