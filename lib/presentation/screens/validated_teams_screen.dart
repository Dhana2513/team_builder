import 'package:flutter/material.dart';
import 'package:team_builder/models/entity/team_entity.dart';
import 'package:team_builder/models/type/captaincy_type.dart';
import 'package:team_builder/models/type/player_type.dart';

import '../../constants/paddings.dart';
import '../../models/entity/match_entity.dart';

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
    const textStyle = TextStyle(
      fontSize: 13,
      color: Colors.black87,
    );

    if (highestPoints < team.points!) {
      highestPoints = team.points!;
      highestPointsTeam = index + 1;
    }

    return [
      Text('Team : ${index + 1}  Points : ${team.points}'),
      padding,
      for (final player in team.players)
        Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                player.playerType.icon,
                color: Colors.black54,
              ),
              Text(
                '${player.name} ${player.captaincyType.shortName}',
                style: textStyle.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Points : ${player.points}',
                style: textStyle,
              ),
            ]),
      paddingLarge,
    ];
  }

  List<Widget> getMatchDetails(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {});
    });

    return [
      Text(
        '${match.matchName}    HighestPoints : $highestPoints (Team: $highestPointsTeam)',
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
