import 'player.dart';

class Team {
  final List<Player> defender;
  final List<Player> raider;
  final List<Player> allRounders;

  Team({
    required this.defender,
    required this.raider,
    required this.allRounders,
  });
}
