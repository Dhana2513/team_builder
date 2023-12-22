import 'package:team_builder/models/type/captaincy_type.dart';

import '../type/player_type.dart';
import '../type/team_type.dart';

class Player extends Object {
  final String? id;
  final TeamType teamType;
  final String name;
  final PlayerType playerType;
  final double dmPoints;

  final int playerRating;
  final int captaincyRating;
  bool mustHave;
  double points;

  CaptaincyType captaincyType;

  Player({
    this.id,
    required this.teamType,
    required this.name,
    required this.playerType,
    required this.playerRating,
    required this.captaincyRating,
    required this.mustHave,
    required this.dmPoints,
    this.points = 0,
    this.captaincyType = CaptaincyType.none,
  });

  bool get isCaptain => captaincyType == CaptaincyType.captain;

  bool get isViceCaptain => captaincyType == CaptaincyType.viceCaptain;

  bool isSame({required Player? player}) {
    return name == player?.name &&
        teamType == player?.teamType &&
        playerType == player?.playerType;
  }

  factory Player.fromJson(Map<String, dynamic> json, {String? id}) {
    return Player(
      id: id,
      teamType: TeamTypeX.fromName(name: json[PlayerKeys.teamType]),
      name: json[PlayerKeys.name],
      playerType: PlayerTypeX.fromName(name: json[PlayerKeys.playerType]),
      playerRating: json[PlayerKeys.playerRating],
      mustHave: json[PlayerKeys.mustHave],
      captaincyRating: json[PlayerKeys.captaincyRating],
      points:
          json.containsKey(PlayerKeys.points) ? json[PlayerKeys.points] : 0.0,
      dmPoints: json.containsKey(PlayerKeys.dmPoints)
          ? json[PlayerKeys.dmPoints]
          : 0.0,
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
      PlayerKeys.mustHave: mustHave,
      PlayerKeys.points: points,
      PlayerKeys.dmPoints: dmPoints,
    };
  }

  Player copyWith({
    String? id,
    TeamType? teamType,
    String? name,
    PlayerType? playerType,
    int? playerRating,
    int? captaincyRating,
    bool? mustHave,
    double? points = 0,
    double? dmPoints = 0,
    CaptaincyType? captaincyType,
  }) {
    return Player(
      id: id ?? this.id,
      teamType: teamType ?? this.teamType,
      name: name ?? this.name,
      playerType: playerType ?? this.playerType,
      playerRating: playerRating ?? this.playerRating,
      captaincyRating: captaincyRating ?? this.captaincyRating,
      mustHave: mustHave ?? this.mustHave,
      points: points ?? this.points,
      dmPoints: dmPoints ?? this.dmPoints,
      captaincyType: captaincyType ?? this.captaincyType,
    );
  }
}

class PlayerKeys {
  static const teamType = 'teamType';
  static const name = 'name';
  static const playerType = 'playerType';
  static const playerRating = 'playerRating';
  static const captaincyRating = 'captaincyRating';
  static const captaincyType = 'captaincyType';
  static const mustHave = 'mustHave';
  static const points = 'points';
  static const dmPoints = 'dmPoints';
}
