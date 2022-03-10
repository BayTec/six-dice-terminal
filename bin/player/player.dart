import '../dice/dice.dart';

abstract class Player {
  String name();
  int score();
  int turn();
  List<Dice> dices();
}
