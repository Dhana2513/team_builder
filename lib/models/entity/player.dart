import '../type/bowling_type.dart';
import '../type/player_type.dart';
import '../type/team_type.dart';

class Player {
  final String? id;
  final TeamType teamType;
  final String name;
  final PlayerType playerType;
  final BowlingType bowlingType;

  final int playerRating;
  final int captaincyRating;

  Player({
    this.id,
    required this.teamType,
    required this.name,
    required this.playerType,
    required this.bowlingType,
    required this.playerRating,
    required this.captaincyRating,
  });

  factory Player.fromJson(Map<String, dynamic> json, {String? id}) {
    return Player(
      id: id,
      teamType: TeamTypeX.fromName(name: json[PlayerKeys.teamType]),
      name: json[PlayerKeys.name],
      playerType: PlayerTypeX.fromName(name: json[PlayerKeys.playerType]),
      bowlingType: BowlingTypeX.fromName(name: json[PlayerKeys.bowlingType]),
      playerRating: json[PlayerKeys.playerRating],
      captaincyRating: json[PlayerKeys.captaincyRating],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      PlayerKeys.teamType: teamType.shortName,
      PlayerKeys.name: name,
      PlayerKeys.playerType: playerType.name,
      PlayerKeys.bowlingType: bowlingType.name,
      PlayerKeys.playerRating: playerRating,
      PlayerKeys.captaincyRating: captaincyRating,
    };
  }
}

class PlayerKeys {
  static const teamType = 'teamType';
  static const name = 'name';
  static const playerType = 'playerType';
  static const bowlingType = 'bowlingType';
  static const playerRating = 'playerRating';
  static const captaincyRating = 'captaincyRating';
}
