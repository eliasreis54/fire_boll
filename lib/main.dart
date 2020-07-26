import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:flame/time.dart';
import 'package:flame/flame.dart';
import 'dart:math';

void main() async {
  Size size = await Flame.util.initialDimensions();
  runApp(GameWidget(size));
}

class GameWidget extends StatelessWidget {
  final Size size;

  GameWidget(this.size);

  @override
  Widget build(BuildContext context) {
    final game = SpaceShooterGame(size);
    return GestureDetector(
      onPanUpdate: (DragUpdateDetails details) => game.onPlayerMove(details.delta),
      child: Container(
          color: Color(0XFF000000),
          child: game.widget,
      ),
    );
  }
}

class GameObject {
  bool inPlayer = false;

  Rect position;

  void render(Canvas canvas, Paint paint) {
    canvas.drawRect(position, paint);
  }
}

class SpaceShooterGame extends Game {
  final Paint playerColor = Paint()..color = Color(0xFFFFFFFFF);
  final Paint enemyColor = Paint()..color = Color(0xFFF005577);
  final Size screenSize;
  double enemy_speed = 50;
  double enemyTimer = 2.0;

  Random random = Random();
  Timer enemyCreator;

  GameObject player;

  List<GameObject> enemies = [];

  SpaceShooterGame(this.screenSize) {
    player = GameObject()
        ..position = Rect.fromLTWH(100, 100, 70, 70);
    enemyCreator = Timer(enemyTimer, repeat: true, callback: () {
      enemies.add(GameObject()
          ..position = Rect.fromLTWH((screenSize.width - 50) * random.nextDouble(), 0, 50, 50)
      );
    });
    enemyCreator.start();
  }

  void onPlayerMove(Offset delta) {
    player.position = player.position.translate(delta.dx, delta.dy);
  }

  @override
  void update(double dt) {
    enemyCreator.update(dt);
    enemies.forEach((enemy) {
      enemy.position = enemy.position.translate(0, (enemy_speed * dt));
      final inTop = enemy.position.top >= player.position.top;
      final inBottom = enemy.position.bottom <= player.position.bottom;
      final inLeft = enemy.position.left >= player.position.left;
      final inRigth = enemy.position.right <= player.position.right;
      if (inTop && inBottom && inLeft && inRigth) {
        enemy.inPlayer = true;
        enemy_speed = enemy_speed + 10;
      }
    });

    enemies.removeWhere((enemy) {
      return enemy.position.top >= screenSize.height || enemy.inPlayer;
    });
  }

  @override
  void render(Canvas canvas) {
    player.render(canvas, playerColor);

    enemies.forEach((enemy) {
      enemy.render(canvas, enemyColor);
    });
  }
}
