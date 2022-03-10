import 'dart:io';

import 'dice/dice.dart';
import 'dice/six_dice.dart';
import 'game/terminal_game.dart';
import 'player/bot_player.dart';
import 'player/player.dart';
import 'player/terminal_player.dart';

void main(List<String> arguments) {
  var playerCount = 0;
  var botCount = 0;

  List<Player> players = [];

  print('Welcome to Six Dice!');

  while (true) {
    print('How many are you?');
    var input = stdin.readLineSync();
    if (input != null) {
      var inputInt = int.tryParse(input);
      if (inputInt != null) {
        playerCount = inputInt;
        break;
      }
    }
    print('Plese enter a valid value.');
  }

  while (true) {
    print('How many bots do you want?');
    var input = stdin.readLineSync();
    if (input != null) {
      var inputInt = int.tryParse(input);
      if (inputInt != null) {
        botCount = inputInt;
        break;
      }
    }
    print('Plese enter a valid value.');
  }

  for (var i = 1; i <= playerCount; i++) {
    while (true) {
      print('Player $i, enter your name:');
      var input = stdin.readLineSync();
      if (input != null) {
        List<Dice> dices = [];
        for (var x = 0; x < 6; x++) {
          dices.add(SixDice());
        }
        players.add(TerminalPlayer(dices, input));
        break;
      }
      print('Plese enter a valid name.');
    }
  }

  for (var i = 1; i <= botCount; i++) {
    while (true) {
      print('Enter the name for Bot $i:');
      var input = stdin.readLineSync();
      if (input != null) {
        List<Dice> dices = [];
        for (var x = 0; x < 6; x++) {
          dices.add(SixDice());
        }
        players.add(BotPlayer(dices, input));
        break;
      }
      print('Plese enter a valid name.');
    }
  }

  print('Have fun...');
  TerminalGame(players).play();
}
