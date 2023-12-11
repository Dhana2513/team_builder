import 'package:flutter/material.dart';
import 'package:team_builder/models/entity/team_entity.dart';

import '../../constants/paddings.dart';
import '../../models/entity/match_entity.dart';
import '../widgets/player_row_tile.dart';

class MatchTeamsViewScreen extends StatefulWidget {
  const MatchTeamsViewScreen({Key? key}) : super(key: key);
  static const routeName = '/matchTeamsView';

  @override
  State<MatchTeamsViewScreen> createState() => _MatchTeamsViewScreenState();
}

class _MatchTeamsViewScreenState extends State<MatchTeamsViewScreen> {
  MatchEntity? matchEntity;

  MatchEntity get match {
    matchEntity ??= ModalRoute.of(context)!.settings.arguments as MatchEntity;

    return matchEntity!;
  }

  List<Widget> getTeam(TeamEntity team, int index) {
    return [
      Text('Team : ${index + 1}'),
      padding,
      for (int i = 0; i < team.players.length; i++)
        PlayerRowTile(player: team.players[i]),
      paddingLarge,
    ];
  }

  List<Widget> getMatchDetails(BuildContext context) {
    return [
      Text(
        match.matchName,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      padding,
      for (int i = 0; i < match.teams.length; i++) ...getTeam(match.teams[i], i)
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: getMatchDetails(context),
        ),
      ),
    );
  }
}
