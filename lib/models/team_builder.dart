import 'dart:math';

import 'package:team_builder/core/dbutil.dart';
import 'package:team_builder/models/entity/player.dart';
import 'package:team_builder/models/entity/team_model.dart';
import 'package:team_builder/models/players_model.dart';
import 'package:team_builder/models/type/pitch_type.dart';
import 'package:team_builder/models/type/player_type.dart';
import 'package:team_builder/models/type/team_type.dart';

class TeamBuilder {
  final TeamType teamType1;
  final TeamType teamType2;

  final PitchType pitchType;
  final int numberOfTeams;
  final int averageScore;

  TeamBuilder({
    required this.teamType1,
    required this.teamType2,
    required this.pitchType,
    required this.numberOfTeams,
    required this.averageScore,
  });

  late final bool battingPitch;
  late final bool bowlingPitch;

  late final int allRounderCount;
  late final int keeperCount;

  final random = Random();
  final List<Player> allPlayers = [];
  late final PlayersModel playersModel;

  void build() async {
    final allTeamPlayers = await DbUtil.instance.allPlayers();
    battingPitch = averageScore >= 250;
    bowlingPitch = averageScore <= 200;

    allPlayers.addAll(allTeamPlayers
        .where((player) =>
            [teamType1, teamType2].contains(player.teamType) &&
            player.playerRating >= 10)
        .toList());

    playersModel = PlayersModel(players: allPlayers);

    allRounderCount = playerCount(PlayerType.allRounder);
    keeperCount = playerCount(PlayerType.keeper);

    int count = numberOfTeams;

    List<List<Player>> selectedTeams = [];

    while (count != 0) {
      final teamModel = pickRandomTeamModel();

      final keepers = selectPlayers(
        playerType: PlayerType.keeper,
        count: teamModel.wk,
      );

      final batsmans = selectPlayers(
        playerType: PlayerType.batsman,
        count: teamModel.bt,
      );

      final allRounders = selectPlayers(
        playerType: PlayerType.allRounder,
        count: teamModel.ar,
      );

      final bowlers = selectPlayers(
        playerType: PlayerType.bowler,
        count: teamModel.bl,
      );

      final List<Player> team = [
        ...keepers,
        ...batsmans,
        ...allRounders,
        ...bowlers
      ];

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

  List<Player> selectPlayers(
      {required PlayerType playerType, required int count}) {
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
    final moreThanThreeAllRounder = allRounderCount >= 3;

    int blCount = battingPitch
        ? pickRandom(moreThanThreeAllRounder ? 2 : 3, 4)
        : pickRandom(moreThanThreeAllRounder ? 3 : 4, 5);

    int alCount = pickRandom(
        allRounderCount >= 4 ? 2 : pickRandom(1, 2), allRounderCount);

    int wkCount = pickRandom(1, keeperCount);

    int btCount = 11 - blCount - alCount - wkCount;

    return TeamModel(wk: wkCount, bt: btCount, ar: alCount, bl: blCount);
  }

  int pickRandom(int min, int max) {
    return min + random.nextInt(max - min);
  }
}
