import 'package:flutter/material.dart';
import 'package:team_builder/constants/paddings.dart';
import 'package:team_builder/core/dbutil.dart';
import 'package:team_builder/models/entity/match_entity.dart';
import 'package:team_builder/presentation/screens/validated_teams_screen.dart';
import 'package:team_builder/presentation/widgets/player_points_row_tile.dart';

import '../../core/widgets/common_app_bar.dart';
import '../../models/entity/player.dart';

class ValidateTeamsScreen extends StatefulWidget {
  const ValidateTeamsScreen({Key? key}) : super(key: key);

  static const routeName = '/validateTeams';

  @override
  _ValidateTeamsScreenState createState() => _ValidateTeamsScreenState();
}

class _ValidateTeamsScreenState extends State<ValidateTeamsScreen> {
  MatchEntity? matchEntity;
  List<Player> allPlayers = [];

  MatchEntity get match {
    if (matchEntity == null) {
      matchEntity = ModalRoute.of(context)!.settings.arguments as MatchEntity?;
      fillUpAllPlayerList();
    }

    return matchEntity!;
  }

  void fillUpAllPlayerList() {
    for (var team in match.teams) {
      for (var player in team.players) {
        bool foundInList = false;
        for (var pl in allPlayers) {
          if (pl.name == player.name && pl.teamType == player.teamType) {
            foundInList = true;
            break;
          }
        }

        if (!foundInList) {
          allPlayers.add(player.copyWith(points: 0.0));
        }
      }
    }

    allPlayers.sort((a, b) {
      return a.playerType == b.playerType ? 0 : 1;
    });

    allPlayers = allPlayers.reversed.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: 'Validate Teams : ${match.matchName}',
      ),
      body: ListView(
        children: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: allPlayers.length,
            itemBuilder: (context, index) {
              return PlayerPointsRowTile(player: allPlayers[index]);
            },
          ),
          paddingLarge,
          ElevatedButton(
              onPressed: validateTeams, child: const Text('Validate')),
          paddingLarge,
        ],
      ),
    );
  }

  void validateTeams() {
    for (var team in match.teams) {
      double teamPoints = 0;
      for (var player in team.players) {
        final selectedPlayer = allPlayers.firstWhere(
            (pl) => pl.name == player.name && pl.teamType == player.teamType);

        if (player.isCaptain) {
          player.points = selectedPlayer.points * 2;
        } else if (player.isViceCaptain) {
          player.points = selectedPlayer.points * 1.5;
        } else {
          player.points = selectedPlayer.points;
        }

        teamPoints += player.points;
      }

      team.points = teamPoints;
    }

    DbUtil.instance.updateMatch(
      docID: match.id,
      matchEntity: match,
    );

    Navigator.of(context)
        .pushReplacementNamed(ValidatedTeamsScreen.routeName, arguments: match);
  }
}
