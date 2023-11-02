import 'package:flutter/material.dart';
import 'package:team_builder/constants/paddings.dart';
import 'package:team_builder/presentation/screens/add_player_screen.dart';
import 'package:team_builder/presentation/screens/all_players_screen.dart';

import '../core/widgets/common_app_bar.dart';
import 'screens/create_teams_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const routeName = '/';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: 'Team Builder',
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => navigateTo(routeName: AddPlayerScreen.routeName),
        child: const Icon(Icons.person_add_alt),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () =>
                  navigateTo(routeName: AllPlayersScreen.routeName),
              child: const Text('All Players'),
            ),
            paddingExtraLarge,
            ElevatedButton(
              onPressed: () =>
                  navigateTo(routeName: CreateTeamsScreen.routeName),
              child: const Text('Create Teams'),
            ),
          ],
        ),
      ),
    );
  }

  void navigateTo({required String routeName}) {
    Navigator.of(context).pushNamed(routeName);
  }
}
