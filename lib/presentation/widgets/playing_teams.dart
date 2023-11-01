import 'package:flutter/material.dart';
import 'package:team_builder/models/type/team_type.dart';
import 'package:team_builder/presentation/widgets/team_view.dart';

import '../../core/dbutil.dart';
import '../../models/entity/player.dart';

class PlayingTeams extends StatefulWidget {
  const PlayingTeams({
    Key? key,
    required this.teamType1,
    required this.teamType2,
  }) : super(key: key);

  final TeamType? teamType1;
  final TeamType? teamType2;

  @override
  _PlayingTeamsState createState() => _PlayingTeamsState();
}

class _PlayingTeamsState extends State<PlayingTeams> {
  late Future<List<Player>> futurePlayers;

  @override
  void initState() {
    super.initState();
    fetchAllPlayers();
  }

  void fetchAllPlayers() {
    futurePlayers = DbUtil.instance.allPlayers();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.teamType1 == null || widget.teamType2 == null) {
      return const SizedBox.shrink();
    }

    return FutureBuilder<List<Player>>(
      future: futurePlayers,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox.shrink();
        }

        final players = snapshot.data!;

        final playingTeamPlayers = players
            .where((player) =>
                [widget.teamType1, widget.teamType2].contains(player.teamType))
            .toList();

        return TeamView(
          players: playingTeamPlayers,
          onPlayerUpdate: () {
            fetchAllPlayers();
            setState(() {});
          },
        );
      },
    );
  }
}
