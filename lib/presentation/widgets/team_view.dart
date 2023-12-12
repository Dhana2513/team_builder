import 'package:flutter/material.dart';
import 'package:team_builder/models/entity/player.dart';
import 'package:team_builder/models/type/team_type.dart';
import 'package:team_builder/presentation/widgets/player_table.dart';

import '../../constants/paddings.dart';
import '../../models/players_model.dart';

class TeamView extends StatefulWidget {
  const TeamView({
    Key? key,
    required this.players,
    required this.onPlayerUpdate,
  }) : super(key: key);

  final List<Player> players;
  final VoidCallback? onPlayerUpdate;

  @override
  State<TeamView> createState() => _TeamViewState();
}

class _TeamViewState extends State<TeamView> {
  Widget getItem(
    BuildContext context,
    TeamType teamType,
    List<Player> teamPlayers,
  ) {
    return Column(
      children: [
        Text(
          teamType.longName,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        padding,
        PlayerTable(
          players: teamPlayers,
          onPlayerUpdate: widget.onPlayerUpdate,
        ),
        paddingLarge,
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final playersModel = PlayersModel(players: widget.players);
    final teams = playersModel.allTeamTypes();
    return Column(
      children: teams
          .map(
            (team) => getItem(
              context,
              team,
              playersModel.playersByTeam(teamType: team),
            ),
          )
          .toList(),
    );
  }
}
