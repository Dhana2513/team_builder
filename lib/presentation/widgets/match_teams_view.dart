import 'package:flutter/material.dart';

import '../../constants/paddings.dart';
import '../../models/entity/match_entity.dart';
import '../../models/entity/player.dart';
import 'player_row_tile.dart';

class MatchTeamsView extends StatelessWidget {
  const MatchTeamsView({Key? key, required this.match}) : super(key: key);

  final MatchEntity match;

  List<Widget> getTeam(List<Player> team, int index) {
    return [
      Text('Team : ${index + 1}'),
      padding,
      for (int i = 0; i < team.length; i++) PlayerRowTile(player: team[i]),
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
