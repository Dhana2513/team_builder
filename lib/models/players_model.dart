import 'package:team_builder/models/type/team_type.dart';

import 'entity/player.dart';
import 'type/player_type.dart';

class PlayersModel {
  final List<Player> players;

  PlayersModel({
    required this.players,
  });

  List<Player> playersByTeam({required TeamType teamType}) {
    final teamPlayers =
        players.where((player) => player.teamType == teamType).toList();

    final raiders = teamPlayers
        .where((player) => player.playerType == PlayerType.raider)
        .toList();

    final defenders = teamPlayers
        .where((player) => player.playerType == PlayerType.defender)
        .toList();

    final allRounders = teamPlayers
        .where((player) => player.playerType == PlayerType.allRounder)
        .toList();

    teamPlayers.clear();
    teamPlayers.addAll(defenders);
    teamPlayers.addAll(allRounders);
    teamPlayers.addAll(raiders);

    return teamPlayers;
  }

  List<Player> playersByPlayerType({required PlayerType playerType}) {
    return players.where((player) => player.playerType == playerType).toList();
  }

  List<TeamType> allTeamTypes() {
    return players.map((player) => player.teamType).toSet().toList();
  }
}
