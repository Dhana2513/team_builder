import 'package:team_builder/models/entity/team_entity.dart';

class MatchEntity {
  final String id;
  final String matchName;
  final bool validated;
  final List<TeamEntity> teams;

  MatchEntity({
    required this.id,
    required this.matchName,
    required this.validated,
    required this.teams,
  });

  factory MatchEntity.fromJson({
    required String id,
    required String matchName,
    required bool validated,
    required List<dynamic> jsonList,
  }) {
    final List<TeamEntity> allTeams = [];
    for (final teams in jsonList) {
      allTeams.add(TeamEntity.fromJson(teams));
    }

    return MatchEntity(
      id: id,
      matchName: matchName,
      validated: validated,
      teams: allTeams,
    );
  }
}
