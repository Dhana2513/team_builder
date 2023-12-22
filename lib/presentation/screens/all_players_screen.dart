import 'package:flutter/material.dart';
import 'package:team_builder/core/dbutil.dart';
import 'package:team_builder/presentation/widgets/team_view.dart';

import '../../core/widgets/common_app_bar.dart';
import '../../models/entity/player.dart';
import 'add_player_screen.dart';

class AllPlayersScreen extends StatefulWidget {
  const AllPlayersScreen({Key? key}) : super(key: key);

  static const routeName = '/allPlayers';

  @override
  _AllPlayersScreenState createState() => _AllPlayersScreenState();
}

class _AllPlayersScreenState extends State<AllPlayersScreen> {
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
    return Scaffold(
      appBar: CommonAppBar(
        title: 'All Players',
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => navigateTo(routeName: AddPlayerScreen.routeName),
        child: const Icon(Icons.person_add_alt),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: FutureBuilder<List<Player>>(
          future: futurePlayers,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const SizedBox.shrink();
            }

            final players = snapshot.data!;

            return ListView(
              children: [
                TeamView(
                  players: players,
                  onPlayerUpdate: () {
                    fetchAllPlayers();
                    setState(() {});
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void navigateTo({required String routeName}) {
    Navigator.of(context).pushNamed(routeName);
  }
}
