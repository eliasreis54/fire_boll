import 'package:flutter/material.dart';

class SelectDifficulty extends StatelessWidget {
  final Function onSelect;

  SelectDifficulty(this.onSelect);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Nível de dificuldade',
              textDirection: TextDirection.rtl,
            ),
            RaisedButton(
              onPressed: () => this.onSelect(100.0),
              child: Text(
                'fácil',
              ),
            ),
            RaisedButton(
              onPressed: () => this.onSelect(200.0),
              child: Text(
                'médio',
              ),
            ),
            RaisedButton(
              onPressed: () => this.onSelect(300.0),
              child: Text(
                'difícil',
              ),
            ),
            RaisedButton(
              onPressed: () => this.onSelect(600.0),
              child: Text(
                'insano',
              ),
            ),
            RaisedButton(
              onPressed: () => this.onSelect(800.0),
              child: Text(
                '2020',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
