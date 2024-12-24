import 'package:expense_tracker/core/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart';

class ArcValueModel {
  final Color color;
  final double value;

  ArcValueModel({required this.color, required this.value});
}

class AmountProgressBar extends CustomPainter {
  final double start;
  final double end;
  final double width;
  final double bgWidth;
  final double blurWidth;
  final double space;
  final List<ArcValueModel> drwArcs;

  AmountProgressBar({
    required this.drwArcs,
    this.start = 0,
    this.end = 360,
    this.space = 5,
    this.width = 15,
    this.bgWidth = 10,
    this.blurWidth = 4,
  });

  @override
  void paint(Canvas canvas, Size size) {
    var rect = Rect.fromCircle(
      center: Offset(size.width / 2, size.height / 2), // Center circle
      radius: size.width / 2,
    );

    Paint backgroundPaint = Paint()
      ..color = gray40.withOpacity(0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = bgWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(rect, radians(start), radians(end), false, backgroundPaint);

    double drawStart = start;
    for (var arcObj in drwArcs) {
      Paint shadowPaint = Paint()
        ..color = arcObj.color.withOpacity(0.3)
        ..style = PaintingStyle.stroke
        ..strokeWidth = width + blurWidth
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5);

      Paint activePaint = Paint()
        ..color = arcObj.color
        ..style = PaintingStyle.stroke
        ..strokeWidth = width
        ..strokeCap = StrokeCap.round;

      canvas.drawArc(rect, radians(drawStart), radians(arcObj.value - space),
          false, shadowPaint);

      canvas.drawArc(rect, radians(drawStart), radians(arcObj.value - space),
          false, activePaint);

      drawStart += arcObj.value + space;
    }
  }

  @override
  bool shouldRepaint(AmountProgressBar oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(AmountProgressBar oldDelegate) => false;
}
