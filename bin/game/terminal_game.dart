import '../player/player.dart';
import 'game.dart';

class TerminalGame implements Game {
  final List<Player> _players;

  TerminalGame(this._players);

  @override
  void play() {
    List<Player> winners = [];

    do {
      for (final player in _players) {
        player.turn();

        if (player.score() >= 5000) {
          winners.add(player);
        }
      }
    } while (winners.isEmpty);

    for (final winner in winners) {
      print('Player: ${winner.name()} won!');
    }
  }

  @override
  List<Player> players() => _players;
}
