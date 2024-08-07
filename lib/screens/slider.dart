import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_openui/utils/colors.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:syncfusion_flutter_core/theme.dart';

class AppSlider extends StatefulWidget {
  final void Function(dynamic)? onChanged;
  const AppSlider({super.key, this.onChanged});

  @override
  State<AppSlider> createState() => _AppSliderState();
}

class _AppSliderState extends State<AppSlider> {
  double _value = 2.0;

  @override
  Widget build(BuildContext context) {
    return SfSliderTheme(
      data: SfSliderThemeData(
        activeLabelStyle: Theme.of(context).textTheme.displaySmall,
        inactiveLabelStyle: Theme.of(context).textTheme.displaySmall,
        labelOffset: Offset(0.0, 30.0),
        activeTrackColor: AppColors.bgBlack.withOpacity(0.2),
        inactiveTrackColor: AppColors.bgBlack.withOpacity(0.2),
      ),
      child: SfSlider(
        min: 0.0,
        max: 2.0,
        value: _value,
        interval: 1,
        showDividers: true,
        showLabels: true,
        labelFormatterCallback: (dynamic actualValue, String formattedText) {
          return actualValue == 0
              ? 'Bad'
              : actualValue == 1
                  ? 'Not Bad'
                  : 'Good';
        },
        dividerShape: _DividerShape(),
        thumbShape: _SfThumbShape(animateAngle: _value >= 1 ? _value * 1 : 1),
        onChanged: (dynamic newValue) {
          if (widget.onChanged != null) widget.onChanged!(newValue);
          setState(() {
            _value = newValue;
          });
        },
      ),
    );
  }
}

class _DividerShape extends SfDividerShape {
  @override
  void paint(
    PaintingContext context,
    Offset center,
    Offset? thumbCenter,
    Offset? startThumbCenter,
    Offset? endThumbCenter, {
    required RenderBox parentBox,
    required SfSliderThemeData themeData,
    SfRangeValues? currentValues,
    dynamic currentValue,
    required Paint? paint,
    required Animation<double> enableAnimation,
    required TextDirection textDirection,
  }) {
    bool isActive;

    switch (textDirection) {
      case TextDirection.ltr:
        isActive = center.dx <= thumbCenter!.dx;
        break;
      case TextDirection.rtl:
        isActive = center.dx >= thumbCenter!.dx;
        break;
    }

    context.canvas.drawCircle(
      center,
      10.0,
      Paint()
        ..isAntiAlias = true
        ..style = PaintingStyle.fill
        ..color = AppColors.bgBlack,
    );
  }
}

class _SfThumbShape extends SfThumbShape {
  final double animateAngle;

  _SfThumbShape({required this.animateAngle});
  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required RenderBox parentBox,
    required RenderBox? child,
    required SfSliderThemeData themeData,
    SfRangeValues? currentValues,
    dynamic currentValue,
    required Paint? paint,
    required Animation<double> enableAnimation,
    required TextDirection textDirection,
    required SfThumb? thumb,
  }) {
    final Path path = Path();
    double radius = 10.0; // Radius of the arc
    double startAngle = pi * animateAngle; // Starting angle in radians
    double sweepAngle = 3.14; // Sweep angle in radians (half-circle)

    // Calculate the start and end points of the arc
    Offset startPoint = Offset(
      center.dx + radius * cos(startAngle),
      center.dy + radius * sin(startAngle),
    );
    Offset endPoint = Offset(
      center.dx + radius * cos(startAngle + sweepAngle),
      center.dy + radius * sin(startAngle + sweepAngle),
    );

    // Calculate control points for the Bézier curve
    double controlPointDistance = radius * (4 / 3) * tan(sweepAngle / 4);
    Offset controlPoint1 = Offset(
      startPoint.dx - controlPointDistance * sin(startAngle),
      startPoint.dy + controlPointDistance * cos(startAngle),
    );
    Offset controlPoint2 = Offset(
      endPoint.dx + controlPointDistance * sin(startAngle + sweepAngle),
      endPoint.dy - controlPointDistance * cos(startAngle + sweepAngle),
    );

    // Move to the start point
    path.moveTo(startPoint.dx, startPoint.dy);

    // Draw the arc using Bézier curves
    path.cubicTo(
      controlPoint1.dx,
      controlPoint1.dy,
      controlPoint2.dx,
      controlPoint2.dy,
      endPoint.dx,
      endPoint.dy,
    );

    // Draw the path on the canvas

    context.canvas.drawCircle(
      center,
      20,
      Paint()
        ..color = AppColors.bgBlack
        ..style = PaintingStyle.fill
        ..strokeCap = StrokeCap.round
        ..strokeWidth = 2,
    );
    context.canvas.drawPath(
      path,
      Paint()
        ..color = Colors.white.withOpacity(0.1)
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..strokeWidth = 5,
    );
  }
}
