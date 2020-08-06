import 'package:flutter/material.dart';

class GameObject {
  bool inPlayer = false;

  Rect position;

  void render(Canvas canvas, Paint paint) {
    canvas.drawRect(position, paint);
  }
}
