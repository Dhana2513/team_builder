import 'dart:math';

import 'package:team_builder/core/dbutil.dart';
import 'package:team_builder/models/entity/player.dart';
import 'package:team_builder/models/entity/team_entity.dart';
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
  int mustHaveRaiderCount = 1;
  int mustHaveAllRounderCount = 1;

  void build() async {
    final allTeamPlayers = await DbUtil.instance.allPlayers();

    allPlayers.addAll(allTeamPlayers
        .where((player) =>
            [teamType1, teamType2].contains(player.teamType) &&
            player.playerRating >= 10)
        .toList());

    playersModel = PlayersModel(players: allPlayers);

    allRounderCount = playerCount(PlayerType.allRounder);

    mustHaveRaiderCount = playersModel.players
        .where((element) =>
            element.playerType == PlayerType.raider && element.mustHave)
        .toList()
        .length;

    mustHaveRaiderCount = mustHaveRaiderCount == 0 ? 1 : mustHaveRaiderCount;

    mustHaveAllRounderCount = playersModel.players
        .where((element) =>
            element.playerType == PlayerType.allRounder && element.mustHave)
        .toList()
        .length;

    mustHaveAllRounderCount =
        mustHaveAllRounderCount == 0 ? 1 : mustHaveAllRounderCount;

    int count = numberOfTeams;

    List<TeamEntity> selectedTeams = [];

    while (count != 0) {
      final teamModel = pickRandomTeamModel();
      print('teamModel.def : ${teamModel.def}');
      print('teamModel.all : ${teamModel.all}');
      print('teamModel.rai : ${teamModel.rai}');

      final defenders = selectPlayers(
        playerType: PlayerType.defender,
        count: teamModel.def,
        mustHavePlayers: playersModel.players
            .where((element) =>
                element.playerType == PlayerType.defender && element.mustHave)
            .toList(),
      );

      final allRounders = selectPlayers(
        playerType: PlayerType.allRounder,
        count: teamModel.all,
        mustHavePlayers: playersModel.players
            .where((element) =>
                element.playerType == PlayerType.allRounder && element.mustHave)
            .toList(),
      );

      final raiders = selectPlayers(
        playerType: PlayerType.raider,
        count: teamModel.rai,
        mustHavePlayers: playersModel.players
            .where((element) =>
                element.playerType == PlayerType.raider && element.mustHave)
            .toList(),
      );

      final List<Player> team = [...defenders, ...allRounders, ...raiders];

      print('team : $team');

      selectedTeams.add(TeamEntity(players: team));
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
    required List<Player> mustHavePlayers,
  }) {
    final List<Player> selectedPlayers = [...mustHavePlayers];
    count -= mustHavePlayers.length;

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
      raiCount = pickRandom(mustHaveRaiderCount, 3);

      alCount = pickRandom(mustHaveAllRounderCount, 2);
    }

    int defCount = 7 - raiCount - alCount;

    return TeamModel(def: defCount, all: alCount, rai: raiCount);
  }

  int pickRandom(int min, int max) {
    final randValue = random.nextInt(100);

    final mod = randValue % max;

    final val = min + mod;
    return val > max ? max : val;
  }
}
