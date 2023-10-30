import '../type/bowling_type.dart';
import '../type/player_type_enum.dart';

class Player {
  final String name;
  final String teamName;
  final int playerRating;
  final int captaincyRating;
  final PlayerType playerType;
  final BowlingType bowlingType;

  Player({
    required this.name,
    required this.teamName,
    required this.playerRating,
    required this.captaincyRating,
    required this.playerType,
    required this.bowlingType,
  });
}
