import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_car_rental/utils/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class CarName extends StatefulWidget {
  final int index;
  const CarName({super.key, required this.index});

  @override
  State<CarName> createState() => _CarNameState();
}

class _CarNameState extends State<CarName> {
  List<Car> carNames = [
    Car("FORD", "MUSTANG"),
    Car("AUDI", "A3"),
    Car("LEXUS", "LC SERIES"),
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          carNames[widget.index].title,
          style: GoogleFonts.poppins(
            fontSize: 50,
            fontWeight: FontWeight.bold,
            color: AppColors.gray.withOpacity(0.74),
          ),
        ),
        Transform.translate(
          offset: const Offset(0, -40),
          child: Text(
            carNames[widget.index].subTitle,
            style: GoogleFonts.poppins(
              fontSize: 200,
              fontWeight: FontWeight.bold,
              height: 0,
              color: AppColors.gray.withOpacity(0.74),
            ),
          ),
        ),
      ],
    );
  }
}

class Car {
  final String title;
  final String subTitle;

  Car(this.title, this.subTitle);
}
