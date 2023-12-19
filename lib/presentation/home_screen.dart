import 'package:flutter/material.dart';
import 'package:team_builder/constants/paddings.dart';
import 'package:team_builder/presentation/screens/add_player_screen.dart';
import 'package:team_builder/presentation/screens/all_players_screen.dart';
import 'package:team_builder/presentation/widgets/match_view.dart';

import '../core/widgets/common_app_bar.dart';
import 'screens/create_teams_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const routeName = '/';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget navigationButton({
    required String title,
    required String routeName,
  }) {
    return SizedBox(
      width: 50,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          child: Text(title),
          onPressed: () => navigateTo(routeName: routeName),
        ),
      ),
    );
  }

  int clickCount = 0;

  bool get godMode => clickCount >= 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: 'Team Builder',
        onTap: () {
          clickCount++;
          if (godMode) {
            setState(() {});
          }
        },
      ),
      floatingActionButton: godMode
          ? FloatingActionButton(
              onPressed: () => navigateTo(routeName: AddPlayerScreen.routeName),
              child: const Icon(Icons.person_add_alt),
            )
          : null,
      body: Container(
        color: Colors.white10,
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            if (godMode) ...[
              navigationButton(
                title: 'All Players',
                routeName: AllPlayersScreen.routeName,
              ),
              navigationButton(
                title: 'Create Teams',
                routeName: CreateTeamsScreen.routeName,
              ),
              paddingLarge,
            ],
            MatchView(
              godMode: godMode,
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
