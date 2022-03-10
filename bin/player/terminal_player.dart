import 'dart:io';

import '../dice/dice.dart';
import 'player.dart';

class TerminalPlayer implements Player {
  int _score = 0;
  final List<Dice> _dices;
  final String _name;

  TerminalPlayer(this._dices, this._name);

  @override
  String name() => _name;

  @override
  List<Dice> dices() => _dices;

  @override
  int score() => _score;

  @override
  int turn() {
    var score = 0;
    while (true) {
      print('Please enter your score.');
      var input = stdin.readLineSync();

      if (input != null) {
        var scoreInput = int.tryParse(input);
        if (scoreInput != null) {
          score += scoreInput;
          break;
        }
      }
      print('${name()}: Please enter a valid score.');
    }

    _score += score;

    print('${name()} in turn: $score');
    print('${name()} total: ${this.score()}');

    return this.score();
  }
}
