import 'package:flutter/material.dart';
import './fire_boll_game.dart';
import './restart_game.dart';

class GameWidget extends StatefulWidget {
  final Size size;

  GameWidget(this.size);

  @override
  _GameWidget createState() => _GameWidget();
}

class _GameWidget extends State<GameWidget> {
  bool _lostGame = false;

  void toggleLostGame() {
    setState(() {
      _lostGame = !this._lostGame;
    });
  }

  @override
  Widget build(BuildContext context) {
    final game =
        FireBollGame(screenSize: widget.size, onLostGame: this.toggleLostGame);
    if (_lostGame) {
      return RestartGame(this.toggleLostGame);
    }

    return GestureDetector(
      onPanUpdate: (DragUpdateDetails details) =>
          game.onPlayerMove(details.delta),
      child: Container(
        color: Color(0XFF000000),
        child: game.widget,
      ),
    );
  }
}
