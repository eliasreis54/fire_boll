import 'package:flutter/material.dart';

class RestartGame extends StatelessWidget {
  final Function onPressRestart;

  RestartGame(this.onPressRestart);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Perdeu o jogo',
              textDirection: TextDirection.rtl,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            RaisedButton(
              onPressed: this.onPressRestart,
              child: Text(
                'Reiniciar',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
