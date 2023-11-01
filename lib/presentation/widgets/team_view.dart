import 'package:flutter/material.dart';
import 'package:team_builder/models/entity/player.dart';
import 'package:team_builder/models/type/team_type.dart';

import '../../constants/paddings.dart';
import '../../models/players_model.dart';
import 'player_row_tile.dart';

class TeamView extends StatelessWidget {
  const TeamView({
    Key? key,
    required this.players,
    required this.onPlayerUpdate,
  }) : super(key: key);

  final List<Player> players;
  final VoidCallback onPlayerUpdate;
  
  Widget getItem(TeamType teamType, List<Player> teamPlayers) {

          return Column(
            children: [
              Text(
                teamType.longName,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              padding,
              for (int i = 0; i < teamPlayers.length; i++)
                PlayerRowTile(
                  player: teamPlayers[i],
                  onPlayerUpdate: onPlayerUpdate,
                ),
              paddingLarge,
            ],
          );
  }

    
  @override
  Widget build(BuildContext context) {
    final playersModel = PlayersModel(players: players);
    final teams = playersModel.allTeams();
     return Column(
       childrens:[
         for(int i=0; i<teams.length; i++)
         return getItem(teams[i], playersModel.playersByTeam(teamType: teams[i]));
         ]
       );
  }
}
