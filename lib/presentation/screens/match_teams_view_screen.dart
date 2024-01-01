import 'package:flutter/material.dart';
import 'package:team_builder/models/entity/team_entity.dart';
import 'package:team_builder/presentation/widgets/player_selection_chart.dart';

import '../../constants/paddings.dart';
import '../../models/entity/match_entity.dart';
import '../widgets/player_table.dart';

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
    double dmPoints = 0;
    for (final player in team.players) {
      dmPoints += player.dmPoints;
    }

    return [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Text('Team : ${index + 1} dmPoints : $dmPoints'),
      ),
      padding,
      PlayerTable(players: team.players),
      paddingLarge,
    ];
  }

  List<Widget> getMatchDetails(BuildContext context) {
    return [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Text(
          match.matchName,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      PlayerSelectionChart(teams: match.teams),
      padding,
      for (int i = 0; i < match.teams.length; i++) ...getTeam(match.teams[i], i)
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: ListView(
          children: getMatchDetails(context),
        ),
      ),
    );
  }
}
