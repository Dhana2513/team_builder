import 'package:flutter/material.dart';
import 'package:team_builder/models/entity/team_entity.dart';
import 'package:team_builder/presentation/widgets/player_table.dart';

import '../../constants/paddings.dart';
import '../../models/entity/match_entity.dart';
import '../widgets/player_selection_chart.dart';

class ValidatedTeamsScreen extends StatefulWidget {
  const ValidatedTeamsScreen({Key? key}) : super(key: key);
  static const routeName = '/validatedTeams';

  @override
  State<ValidatedTeamsScreen> createState() => _ValidatedTeamsScreenState();
}

class _ValidatedTeamsScreenState extends State<ValidatedTeamsScreen> {
  MatchEntity? matchEntity;

  MatchEntity get match {
    matchEntity ??= ModalRoute.of(context)!.settings.arguments as MatchEntity;

    return matchEntity!;
  }

  double highestPoints = 0.0;
  int highestPointsTeam = 0;

  List<Widget> getTeam(TeamEntity team, int index) {
    if (highestPoints < team.points!) {
      highestPoints = team.points!;
      highestPointsTeam = index + 1;
    }

    return [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Text('Team : ${index + 1}  Points : ${team.points}'),
      ),
      padding,
      PlayerTable(players: team.players),
      paddingLarge,
    ];
  }

  List<Widget> getMatchDetails(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {});
    });

    return [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Text(
          '${match.matchName}    HighestPoints : $highestPoints (Team: $highestPointsTeam)',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      PlayerSelectionChart(
        teams: match.teams,
        showPoints: true,
      ),
      padding,
      for (int i = 0; i < match.teams.length; i++) ...getTeam(match.teams[i], i)
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
        child: ListView(
          children: getMatchDetails(context),
        ),
      ),
    );
  }
}
