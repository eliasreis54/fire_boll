import 'package:flutter/material.dart';
import './fire_boll_game.dart';
import './select_difficulty.dart';

class GameWidget extends StatefulWidget {
  final Size size;

  GameWidget(this.size);

  @override
  _GameWidget createState() => _GameWidget();
}

class _GameWidget extends State<GameWidget> {
  FireBollGame _game;
  double _difficult = 0;

  void createGame() {
     _game = FireBollGame(screenSize: widget.size, enemySpeed: this._difficult);
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
    return MaterialApp(
        home:Scaffold(
            backgroundColor: Colors.black,
            body: _game == null ? SelectDifficulty(this.setDifficult) : setBody(),
        ),
    );
  }
}
