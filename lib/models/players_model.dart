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

    final wicketKeepers = teamPlayers
        .where((player) => player.playerType == PlayerType.keeper)
        .toList();

    final batsmans = teamPlayers
        .where((player) => player.playerType == PlayerType.batsman)
        .toList();

    final allRounders = teamPlayers
        .where((player) => player.playerType == PlayerType.allRounder)
        .toList();

    final bowlers = teamPlayers
        .where((player) => player.playerType == PlayerType.bowler)
        .toList();

    teamPlayers.clear();
    teamPlayers.addAll(wicketKeepers);
    teamPlayers.addAll(batsmans);
    teamPlayers.addAll(allRounders);
    teamPlayers.addAll(bowlers);

    return teamPlayers;
  }

  List<Player> playersByPlayerType({required PlayerType playerType}) {
    return players.where((player) => player.playerType == playerType).toList();
  }

  List<TeamType> allTeamTypes() {
    return players.map((player) => player.teamType).toSet().toList();
  }
}
