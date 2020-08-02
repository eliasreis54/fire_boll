import 'package:flutter/material.dart';

class PointsRender {
  void render(Canvas canvas, int points, Size screenSize) {
    final width = ((screenSize.width / 2) - 30);
    final position = Offset(width, 100);

    final text = TextPainter(
      text: TextSpan(
        text: 'Pontos: $points',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: width);
    text.paint(canvas, position);
  }
}
