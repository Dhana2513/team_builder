import 'dart:math';

import 'package:team_builder/core/dbutil.dart';
import 'package:team_builder/models/entity/player.dart';
import 'package:team_builder/models/entity/team_model.dart';
import 'package:team_builder/models/players_model.dart';
import 'package:team_builder/models/type/player_type.dart';
import 'package:team_builder/models/type/team_type.dart';

class TeamBuilder {
  final TeamType teamType1;
  final TeamType teamType2;

  final int numberOfTeams;

  TeamBuilder({
    required this.teamType1,
    required this.teamType2,
    required this.numberOfTeams,
  });

  final random = Random();
  final List<Player> allPlayers = [];
  late final PlayersModel playersModel;

  int allRounderCount = 0;

  void build() async {
    final allTeamPlayers = await DbUtil.instance.allPlayers();

    allPlayers.addAll(allTeamPlayers
        .where((player) =>
            [teamType1, teamType2].contains(player.teamType) &&
            player.playerRating >= 10)
        .toList());

    playersModel = PlayersModel(players: allPlayers);

    allRounderCount = playerCount(PlayerType.allRounder);

    int count = numberOfTeams;

    List<List<Player>> selectedTeams = [];

    while (count != 0) {
      final teamModel = pickRandomTeamModel();

      final defenders = selectPlayers(
        playerType: PlayerType.defender,
        count: teamModel.def,
      );

      final allRounders = selectPlayers(
        playerType: PlayerType.allRounder,
        count: teamModel.all,
      );

      final raiders = selectPlayers(
        playerType: PlayerType.raider,
        count: teamModel.rai,
      );

      final List<Player> team = [...defenders, ...allRounders, ...raiders];

      selectedTeams.add(team);
      count--;
    }

    DbUtil.instance.addMatch(
      matchName: '${teamType1.shortName} vs ${teamType2.shortName}',
      selectedTeams: selectedTeams,
    );
  }

  int playerCount(PlayerType playerType) {
    return allPlayers
        .where((player) =>
            player.playerType == playerType && player.playerRating >= 40)
        .length;
  }

  List<Player> selectPlayers({
    required PlayerType playerType,
    required int count,
  }) {
    final List<Player> selectedPlayers = [];
    final players = playersModel.playersByPlayerType(playerType: playerType);

    final allPlayers = buildPlayersListByRatting(players: players);
    final listSize = allPlayers.length;

    while (count != 0) {
      final player = allPlayers[random.nextInt(listSize)];

      if (!selectedPlayers.contains(player)) {
        selectedPlayers.add(player);
        count--;
      }
    }

    return selectedPlayers;
  }

  List<Player> buildPlayersListByRatting({required List<Player> players}) {
    final List<Player> allPlayers = [];

    for (final player in players) {
      for (int i = 1; i < player.playerRating; i += 10) {
        allPlayers.add(player);
      }
    }

    return allPlayers;
  }

  TeamModel pickRandomTeamModel() {
    int raiCount = 0;
    int alCount = 0;

    while (raiCount + alCount < 3) {
      raiCount = pickRandom(1, 3);

      alCount = pickRandom(1, 2);
    }

    int defCount = 7 - raiCount - alCount;

    return TeamModel(def: defCount, all: alCount, rai: raiCount);
  }

  int pickRandom(int min, int max) {
    return min + random.nextInt(max - min);
  }
}
