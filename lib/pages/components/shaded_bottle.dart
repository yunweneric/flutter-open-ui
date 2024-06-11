import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:ui' as ui;

import 'package:flutter/widgets.dart';
import 'package:flutter_open_animate/pages/components/clipper.dart';
import 'package:flutter_open_animate/utils/colors.dart';
import 'package:flutter_open_animate/utils/sizing.dart';
import 'package:flutter_svg/svg.dart';

class ShadedBottle extends StatefulWidget {
  const ShadedBottle({super.key});

  @override
  State<ShadedBottle> createState() => _ShadedBottleState();
}

class _ShadedBottleState extends State<ShadedBottle> {
  Float64List matrix4 = new Matrix4.identity().storage;
  Future<ui.Image>? imgFuture;

  // New helper function
  Future<ui.Image> loadImageFromFile(String path) async {
    var fileData = Uint8List.sublistView(await rootBundle.load(path));
    return await decodeImageFromList(fileData);
  }

  @override
  void initState() {
    imgFuture = loadImageFromFile("assets/images/pattern.png"); // Works now
    super.initState();
  }

  double translate = 0.0;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: Sizing.width(context) / 2.6,
          child: Transform.translate(
            offset: Offset(0, 0),
            child: FutureBuilder(
              future: imgFuture,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Container(
                    // height: Sizing.height(context) / 2,
                    // color: Colors.amber,
                    child: ShaderMask(
                      blendMode: BlendMode.srcATop,
                      shaderCallback: (_) {
                        return ImageShader(snapshot.data!, TileMode.clamp, TileMode.clamp, matrix4);
                      },
                      child: Transform.translate(
                        offset: Offset(translate, 0),
                        child: Image.asset(
                          "assets/images/bottle.png",
                          height: Sizing.height(context),
                          // color: AppColors.bgBlack,
                          // width: 100,
                          // color: Colors.white,
                        ),
                      ),

                      // child: Text(
                      //   "Hello",
                      //   style: TextStyle(fontSize: 200, color: Colors.white),
                      // ),
                    ),
                  );
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
          ),
        ),
        Image.asset(
          'assets/images/bottle.png',
          width: 300,
          height: 600,
          fit: BoxFit.cover,
        ),
        Slider(
          min: -1000,
          max: 1000,
          value: translate,
          onChanged: (val) {
            setState(() {
              translate = val;
            });
          },
        ),
      ],
    );
  }
}
