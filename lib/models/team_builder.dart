import 'package:team_builder/core/dbutil.dart';
import 'package:team_builder/models/type/pitch_type.dart';
import 'package:team_builder/models/type/team_type.dart';

class TeamBuilder {
  final TeamType teamType1;
  final TeamType teamType2;

  final PitchType pitchType;
  final int numberOfTeams;

  TeamBuilder({
    required this.teamType1,
    required this.teamType2,
    required this.pitchType,
    required this.numberOfTeams,
  });

  void build() async {
    final allPlayers = DbUtil.instance.allPlayers();
  }
}
