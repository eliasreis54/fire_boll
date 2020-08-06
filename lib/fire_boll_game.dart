import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:flame/time.dart';
import './game_object.dart';
import './points.dart';
import 'dart:math';
import './restart_game.dart';

class FireBollGame extends Game with HasWidgetsOverlay {
  final Paint playerColor = Paint()..color = Color(0xFFFFFFFFF);
  final Paint enemyColor = Paint()..color = Color(0xFFF005577);
  final Size screenSize;
  int points = 0;
  double enemySpeed = 50;
  double enemyTimer = 2.0;
  bool startGame = true;
  bool lostGame = false;

  Random random = Random();
  Timer enemyCreator;

  GameObject player;

  List<GameObject> enemies = [];

  FireBollGame({this.screenSize, @required this.enemySpeed}) {
    player = GameObject()..position = Rect.fromLTWH(200, 500, 70, 70);
    enemyCreator = Timer(enemyTimer, repeat: true, callback: () {
      enemies.add(GameObject()
        ..position = Rect.fromLTWH(
            (screenSize.width - 50) * random.nextDouble(), 0, 50, 50));
    });
    enemyCreator.start();
  }

  void onPlayerMove(Offset delta) {
    player.position = player.position.translate(delta.dx, delta.dy);
  }

  void restartGame() {
    points = 0;
    enemyCreator.start();
    lostGame = false;
    player.position = Rect.fromLTWH(200, 500, 70, 70);
  }

  @override
  void update(double dt) {
    enemyCreator.update(dt);
    enemies.forEach((enemy) {
      enemy.position = enemy.position.translate(0, (enemySpeed * dt));
      final inTop = enemy.position.top >= player.position.top;
      final inBottom = enemy.position.bottom <= player.position.bottom;
      final inLeft = enemy.position.left >= player.position.left;
      final inRigth = enemy.position.right <= player.position.right;
      if (inTop && inBottom && inLeft && inRigth) {
        points = points + 1;
        enemy.inPlayer = true;
        enemySpeed = enemySpeed + 10;
      }
    });

    enemies.removeWhere((enemy) {
      bool leaveScreen = enemy.position.top >= screenSize.height;
      if (leaveScreen) {
        lostGame = true;
      }
      return leaveScreen || enemy.inPlayer;
    });
  }

  @override
  void render(Canvas canvas) {
    if (lostGame) {
      enemyCreator.stop();
      enemies.removeWhere((enemy) => !enemy.inPlayer);
      addWidgetOverlay(
        'lostGame',
        Center(
          child: RestartGame(restartGame),
        ),
      );
    } else {
      removeWidgetOverlay('lostGame');
      player.render(canvas, playerColor);

      enemies.forEach((enemy) {
        enemy.render(canvas, enemyColor);
      });
    }
    PointsRender().render(canvas, points, screenSize);
  }
}
