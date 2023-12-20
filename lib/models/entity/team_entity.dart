import 'dart:math';

import 'package:team_builder/models/entity/player.dart';
import 'package:team_builder/models/type/player_type.dart';

import '../type/captaincy_type.dart';
import '../type/team_type.dart';

class TeamEntity {
  final List<Player> players;
  double? points;

  TeamEntity({
    required this.players,
    this.points,
  });

  void _selectCaptains({required List<Player> team}) {
    Random random = Random();

    Player selectCaptain({Player? captain}) {
      final players = [...team];
      final List<Player> allPlayers = [];

      players.removeWhere((player) =>
          player.name == captain?.name &&
          player.playerType == captain?.playerType);

      for (final player in players) {
        for (int i = 1; i < player.captaincyRating; i += 2) {
          allPlayers.add(player);
        }
      }

      allPlayers.shuffle();
      return allPlayers[random.nextInt(allPlayers.length)];
    }

    final captain = selectCaptain();
    final viceCaptain = selectCaptain(captain: captain);

    captain.captaincyType = CaptaincyType.captain;
    viceCaptain.captaincyType = CaptaincyType.viceCaptain;
  }

  bool validateRaiderCount({
    required TeamType teamType1,
    required TeamType teamType2,
  }) {
    final raiders = players
        .where((player) => player.playerType == PlayerType.raider)
        .toList();

    int raider1Count = 0, raider2Count = 0;

    for (final player in raiders) {
      if (player.teamType == teamType1) {
        raider1Count++;
      } else {
        raider2Count++;
      }
    }

    if (raider1Count == 3 || raider2Count == 3) {
      return false;
    }

    return true;
  }

  bool validate({required TeamType teamType1, required TeamType teamType2}) {
    int team1Count = 0, team2Count = 0;

    for (final player in players) {
      if (player.teamType == teamType1) {
        team1Count++;
      } else {
        team2Count++;
      }
    }

    if (team1Count <= 1 || team2Count <= 1) {
      return false;
    }

    if (!validateRaiderCount(teamType1: teamType1, teamType2: teamType2)) {
      return false;
    }

    List<Player> team = [...players];

    if (team1Count >= 5) {
      team = players.where((player) => player.teamType == teamType1).toList();
    } else if (team2Count >= 5) {
      team = players.where((player) => player.teamType == teamType2).toList();
    }

    team.removeWhere((player) => player.captaincyRating <= 10);

    if (team.length < 2) {
      return false;
    }

    _selectCaptains(team: team);

    return true;
  }

  bool isSame({required TeamEntity teamEntity}) {
    Player? captain1, captain2, viceCaptain1, viceCaptain2;

    for (var player1 in teamEntity.players) {
      bool foundPlayer = false;

      captain1 ??= player1.isCaptain ? player1 : null;
      viceCaptain1 ??= player1.isViceCaptain ? player1 : null;

      for (var player2 in players) {
        foundPlayer = player1.isSame(player: player2);

        captain2 ??= player2.isCaptain ? player2 : null;
        viceCaptain2 ??= player2.isViceCaptain ? player2 : null;

        if (foundPlayer) {
          break;
        }
      }

      if (!foundPlayer) {
        return false;
      }
    }

    return captain1?.isSame(player: captain2) == true &&
        viceCaptain1?.isSame(player: viceCaptain2) == true;
  }

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
