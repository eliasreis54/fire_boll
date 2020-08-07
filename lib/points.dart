import 'package:flutter/material.dart';
import 'package:flame/text_config.dart';
import 'package:flame/position.dart';

class PointsRender {
  final TextConfig config = TextConfig(
    fontSize: 25.0,
    color: Colors.white,
  );

  void render(Canvas canvas, int points, Size screenSize) {
    double x = (screenSize.width / 2) - 50;
    double y = (screenSize.height / 6);
    config.render(canvas, "Pontos: $points", Position(x, y));
  }
}
