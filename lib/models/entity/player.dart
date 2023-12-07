import 'package:team_builder/models/type/captaincy_type.dart';

import '../type/player_type.dart';
import '../type/team_type.dart';

class Player {
  final String? id;
  final TeamType teamType;
  final String name;
  final PlayerType playerType;

  final int playerRating;
  final int captaincyRating;

  CaptaincyType captaincyType;

  Player({
    this.id,
    required this.teamType,
    required this.name,
    required this.playerType,
    required this.playerRating,
    required this.captaincyRating,
    this.captaincyType = CaptaincyType.none,
  });

  factory Player.fromJson(Map<String, dynamic> json, {String? id}) {
    return Player(
      id: id,
      teamType: TeamTypeX.fromName(name: json[PlayerKeys.teamType]),
      name: json[PlayerKeys.name],
      playerType: PlayerTypeX.fromName(name: json[PlayerKeys.playerType]),
      playerRating: json[PlayerKeys.playerRating],
      captaincyRating: json[PlayerKeys.captaincyRating],
      captaincyType:
          CaptaincyTypeX.fromName(name: json[PlayerKeys.captaincyType]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      PlayerKeys.teamType: teamType.shortName,
      PlayerKeys.name: name,
      PlayerKeys.playerType: playerType.name,
      PlayerKeys.playerRating: playerRating,
      PlayerKeys.captaincyRating: captaincyRating,
      PlayerKeys.captaincyType: captaincyType.name,
    };
  }
}

class PlayerKeys {
  static const teamType = 'teamType';
  static const name = 'name';
  static const playerType = 'playerType';
  static const playerRating = 'playerRating';
  static const captaincyRating = 'captaincyRating';
  static const captaincyType = 'captaincyType';
}
