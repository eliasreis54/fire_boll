import 'package:flutter/material.dart';
import './fire_boll_game.dart';
import './restart_game.dart';
import './select_difficulty.dart';

class GameWidget extends StatefulWidget {
  final Size size;

  GameWidget(this.size);

  @override
  _GameWidget createState() => _GameWidget();
}

class _GameWidget extends State<GameWidget> {
  bool _lostGame = false;
  FireBollGame _game;
  double _difficult = 0;

  void toggleLostGame() {
    setState(() {
      _lostGame = !this._lostGame;
    });
  }

  void createGame() {
     _game = FireBollGame(screenSize: widget.size, onLostGame: this.toggleLostGame, enemySpeed: this._difficult);
     setState(() {});
  }

  Widget setBody() {
    return GestureDetector(
      onPanUpdate: (DragUpdateDetails details) =>
          _game.onPlayerMove(details.delta),
      child: Container(
        color: Color(0XFF000000),
        child: _game.widget,
      ),
    );
  }

  void setDifficult(double value) {
    setState(() {
      _difficult = value;
    });
    createGame();
  }
  @override
  Widget build(BuildContext context) {
    if (_lostGame) {
      return RestartGame(this.toggleLostGame);
    }

    return MaterialApp(
        home:Scaffold(
            body: _game == null ? SelectDifficulty(this.setDifficult) : setBody(),
        ),
    );
  }
}
