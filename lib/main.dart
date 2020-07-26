import 'package:flutter/material.dart';
import 'package:flame/flame.dart';
import './game_widget.dart';

void main() async {
  Size size = await Flame.util.initialDimensions();
  runApp(GameWidget(size));
}
