import 'package:flutter/material.dart';
import 'package:team_builder/constants/paddings.dart';
import 'package:team_builder/core/dbutil.dart';
import 'package:team_builder/models/entity/player.dart';

import '../../models/entity/match_entity.dart';
import 'player_row_tile.dart';

class MatchView extends StatefulWidget {
  const MatchView({Key? key}) : super(key: key);

  @override
  _MatchViewState createState() => _MatchViewState();
}

class _MatchViewState extends State<MatchView> {
  late final Future<List<MatchEntity>> futureMatches;

  @override
  void initState() {
    super.initState();
    futureMatches = DbUtil.instance.getAllMatches();
  }

  List<Widget> getTeam(List<Player> team, int index) {
    return [
      Text('Team : ${index + 1}'),
      padding,
      for (int i = 0; i < team.length; i++) PlayerRowTile(player: team[i]),
      paddingLarge,
    ];
  }

  List<Widget> getMatchDetails(MatchEntity match) {
    return [
      Text(match.matchName),
      padding,
      for (int i = 0; i < match.teams.length; i++) ...getTeam(match.teams[i], i)
    ];
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<MatchEntity>>(
      future: futureMatches,
      builder: (context, snapshot) {
        print('_MatchViewState snapshot : ${snapshot.data}');

        if (snapshot.data == null) {
          return const SizedBox.shrink();
        }

        final matches = snapshot.data!;

        return Column(
          children: [
            for (int i = 0; i < matches.length; i++)
              ...getMatchDetails(matches[i])
          ],
        );
      },
    );
  }
}
