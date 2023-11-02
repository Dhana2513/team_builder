import 'package:team_builder/models/entity/player.dart';

class MatchEntity {
  final String id;
  final String matchName;
  final List<List<Player>> teams;

  MatchEntity({
    required this.id,
    required this.matchName,
    required this.teams,
  });

  factory MatchEntity.fromJson({
    required String id,
    required String matchName,
    required List<dynamic> jsonList,
  }) {
    final List<List<Player>> allTeams = [];
    for (final teams in jsonList) {
      final List<Player> players = [];
      for (final team in teams) {
        players.add(Player.fromJson(team));
      }
      allTeams.add(players);
    }

    return MatchEntity(id: id, matchName: matchName, teams: allTeams);
  }
}
