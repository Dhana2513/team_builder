import 'package:team_builder/models/entity/player.dart';

class TeamEntity {
  final List<Player> players;
  double? points;

  TeamEntity({
    required this.players,
    this.points,
  });

  factory TeamEntity.fromJson(Map<String, dynamic> json, {String? id}) {
    return TeamEntity(
      players: (json[TeamEntityKeys.players] as List)
          .map((json) => Player.fromJson(json))
          .toList(),
      points: json[TeamEntityKeys.points],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      TeamEntityKeys.players: players.map((player) => player.toJson()).toList(),
      TeamEntityKeys.points: points,
    };
  }
}

class TeamEntityKeys {
  static const players = 'players';
  static const points = 'points';
}
