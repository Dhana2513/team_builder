import 'package:flutter/material.dart';
import 'package:team_builder/constants/paddings.dart';
import 'package:team_builder/core/dbutil.dart';
import 'package:team_builder/models/type/player_type.dart';
import 'package:team_builder/models/type/team_type.dart';

import '../models/entity/player.dart';

class AllPlayersScreen extends StatefulWidget {
  const AllPlayersScreen({Key? key}) : super(key: key);

  @override
  _AllPlayersScreenState createState() => _AllPlayersScreenState();
}

class _AllPlayersScreenState extends State<AllPlayersScreen> {
  late final Future<List<Player>> futurePlayers;

  @override
  void initState() {
    super.initState();
    futurePlayers = DbUtil.instance.allPlayers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: FutureBuilder<List<Player>>(
          future: futurePlayers,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const SizedBox.shrink();
            }

            final players = snapshot.data!;
            final teams =
                players.map((player) => player.teamType).toSet().toList();

            return ListView.builder(
                itemCount: teams.length,
                itemBuilder: (context, index) {
                  final teamType = teams[index];

                  List<Player> teamPlayers = players
                      .where((player) => player.teamType == teamType)
                      .toList();

                  final wicketKeepers = teamPlayers
                      .where((player) => player.playerType == PlayerType.keeper)
                      .toList();

                  final batsmans = teamPlayers
                      .where(
                          (player) => player.playerType == PlayerType.batsman)
                      .toList();

                  final allRounders = teamPlayers
                      .where((player) =>
                          player.playerType == PlayerType.allRounder)
                      .toList();

                  final bowlers = teamPlayers
                      .where((player) => player.playerType == PlayerType.bowler)
                      .toList();

                  teamPlayers.clear();
                  teamPlayers.addAll(wicketKeepers);
                  teamPlayers.addAll(batsmans);
                  teamPlayers.addAll(allRounders);
                  teamPlayers.addAll(bowlers);

                  return Column(
                    children: [
                      Text(teamType.longName),
                      padding,
                      for (int i = 0; i < teamPlayers.length; i++)
                        ListTile(
                          leading: Icon(teamPlayers[i].playerType.icon),
                          title: Text(teamPlayers[i].name),
                        ),
                      largePadding,
                    ],
                  );
                });
          },
        ),
      ),
    );
  }
}
