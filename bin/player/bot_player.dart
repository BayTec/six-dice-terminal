import '../dice/dice.dart';
import 'player.dart';

class BotPlayer implements Player {
  int _score = 0;
  final List<Dice> _dices;
  final String _name;

  BotPlayer(this._dices, this._name);

  @override
  String name() => _name;

  @override
  List<Dice> dices() => _dices;

  @override
  int score() => _score;

  @override
  int turn() {
    int score = 0;
    int prevScore = 0;
    var inDices = <Dice>[];
    final values = _dices.first.values();
    final Map<int, List<Dice>> mappedDices = {};

    inDices.addAll(_dices);

    do {
      // roll all dices
      for (var element in inDices) {
        element.roll();
      }

      print('${name()} rolls with ${inDices.length} dices:');
      for (var dice in inDices) {
        print(dice.value());
      }

      // split dices by values
      for (final value in values) {
        List<Dice> list = [];
        list.addAll(inDices.where((element) => element.value() == value));
        mappedDices[value] = list;
      }

      // Check for strike
      if (inDices.length == _dices.length) {
        var strike = false;
        for (final value in values) {
          if (mappedDices[value]!.length == inDices.length) {
            strike = false;
            break;
          }
        }
        if (strike) {
          score += 5000;
          break;
        }
      }

      // Check for street if all dices where rolled
      var street = true;
      if (inDices.length == _dices.length) {
        for (final value in values) {
          if (mappedDices[value]!.length != 1) {
            street = false;
            break;
          }
        }
        if (street) {
          score += 2000;
          inDices.clear();
        }
      }

      // Check for 3 of a kind
      if (inDices.length >= 3) {
        for (var i = values.length - 1; i >= 0; i--) {
          if (mappedDices[values[i]]!.length >= 3) {
            if (values[i] == 1) {
              score += 1000;
            } else {
              score += values[i] * 100;
            }
            for (var x = 0; x < 3; x++) {
              var index =
                  inDices.indexWhere((element) => element.value() == values[i]);
              inDices.removeAt(index);
            }
            for (var x = 0; x < 3; x++) {
              mappedDices[values[i]]!.removeLast();
            }
            break;
          }
        }
      }

      // Check for 1s and 5s
      List<int> removeIndexes = [];
      for (var i = 0; i < inDices.length; i++) {
        if (inDices[i].value() == 1) {
          score += 100;
          removeIndexes.add(i);
        }
      }

      for (var i = 0; i < removeIndexes.length; i++) {
        inDices.removeAt(removeIndexes[i] - i);
      }

      removeIndexes.clear();

      for (var i = 0; i < inDices.length; i++) {
        if (inDices[i].value() == 5) {
          score += 50;
          removeIndexes.add(i);
        }
      }

      for (var i = 0; i < removeIndexes.length; i++) {
        inDices.removeAt(removeIndexes[i] - i);
      }

      // Check if the score changed
      if (score == prevScore) {
        score = 0;
        break;
      }

      // Check if the score is at least 350 and inDices is not empty
      if (score >= 350 && inDices.isNotEmpty) {
        break;
      }

      // Check if all dices are used
      if (inDices.isEmpty) {
        inDices.addAll(_dices);
      }

      prevScore = score;
    } while (inDices.isNotEmpty);

    print('${name()} in turn: $score');
    _score += score;
    print('${name()} total: $_score');
    return score;
  }
}
