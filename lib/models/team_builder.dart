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

  final possibleTeamModels = [
    TeamModel(def: 2, all: 2, rai: 3),
    TeamModel(def: 2, all: 2, rai: 3),
    TeamModel(def: 2, all: 2, rai: 3),
    //
    TeamModel(def: 3, all: 2, rai: 2),
    TeamModel(def: 3, all: 2, rai: 2),
    TeamModel(def: 3, all: 2, rai: 2),
    TeamModel(def: 3, all: 2, rai: 2),
    TeamModel(def: 3, all: 2, rai: 2),
    //
    TeamModel(def: 4, all: 2, rai: 1),
    TeamModel(def: 4, all: 2, rai: 1),
    //
    TeamModel(def: 4, all: 1, rai: 2),
    TeamModel(def: 4, all: 1, rai: 2),
    TeamModel(def: 4, all: 1, rai: 2),
    //
    TeamModel(def: 3, all: 1, rai: 3),
    TeamModel(def: 3, all: 1, rai: 3),
  ];

  Future<bool> build() async {
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

    possibleTeamModels
        .removeWhere((model) => model.all < mustHaveAllRounderCount);

    possibleTeamModels.removeWhere((model) => model.rai < mustHaveRaiderCount);

    if (solidRaiders) {
      possibleTeamModels.removeWhere((model) => model.rai == 1);
      possibleTeamModels.add(TeamModel(def: 2, all: 2, rai: 3));
      possibleTeamModels.add(TeamModel(def: 3, all: 1, rai: 3));
    }

    if (solidAllRounders) {
      possibleTeamModels.removeWhere((model) => model.all == 1);
    } else if (weakAllRounders) {
      possibleTeamModels.removeWhere((model) => model.all == 2);

      if (allRounderCount >= 2) {
        possibleTeamModels.add(TeamModel(def: 3, all: 2, rai: 2));
        possibleTeamModels.add(TeamModel(def: 2, all: 2, rai: 3));
      }
    }

    if ([teamType1, teamType2].contains(TeamType.puneriPaltan)) {
      possibleTeamModels.clear();
      possibleTeamModels.add(TeamModel(def: 2, all: 2, rai: 3));
      possibleTeamModels.add(TeamModel(def: 3, all: 2, rai: 2));
      possibleTeamModels.add(TeamModel(def: 3, all: 2, rai: 2));
      possibleTeamModels.add(TeamModel(def: 4, all: 2, rai: 1));
      possibleTeamModels.add(TeamModel(def: 4, all: 2, rai: 1));

      if (solidRaiders) {
        possibleTeamModels.add(TeamModel(def: 2, all: 2, rai: 3));
      }
    }

    int count = numberOfTeams;

    List<TeamEntity> selectedTeams = [];

    while (count != 0) {
      final teamModel = pickRandomTeamModel();

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

      final teamEntity = TeamEntity(players: [
        ...defenders.map((player) => player.copyWith()).toList(),
        ...allRounders.map((player) => player.copyWith()).toList(),
        ...raiders.map((player) => player.copyWith()).toList(),
      ]);

      if (teamEntity.validate(teamType1: teamType1, teamType2: teamType2)) {
        bool selectedTeam = false;

        for (var team in selectedTeams) {
          selectedTeam = team.isSame(teamEntity: teamEntity);
          if (selectedTeam) {
            break;
          }
        }

        if (!selectedTeam) {
          selectedTeams.add(teamEntity);
          count--;
        } else {
          print('Same team got created');
        }
      } else {
        print('TeamEntity.validate failed');
      }
    }

    DbUtil.instance.addMatch(
      matchName: '${teamType1.shortName} vs ${teamType2.shortName}',
      selectedTeams: selectedTeams,
    );

    return true;
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
      for (int i = 1; i < player.playerRating; i += 2) {
        allPlayers.add(player);
      }
    }

    allPlayers.shuffle();
    return allPlayers;
  }

  bool get solidAllRounders {
    return rattingOfPlayerType(playerType: PlayerType.allRounder) >= 200;
  }

  bool get weakAllRounders {
    return rattingOfPlayerType(playerType: PlayerType.allRounder) <= 100;
  }

  bool get solidRaiders {
    return rattingOfPlayerType(playerType: PlayerType.raider) >= 260;
  }

  int rattingOfPlayerType({required PlayerType playerType}) {
    int ratting = 0;

    for (final player in allPlayers) {
      if (player.playerType == playerType) {
        ratting += player.playerRating;
      }
    }
    return ratting;
  }

  TeamModel pickRandomTeamModel() {
    possibleTeamModels.shuffle();
    return possibleTeamModels[random.nextInt(possibleTeamModels.length)];
  }
}
