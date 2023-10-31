import 'package:flutter/material.dart';
import 'package:team_builder/presentation/add_player_screen.dart';
import 'package:team_builder/presentation/all_players_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {},
            child: const Icon(Icons.add),
          ),
          const SizedBox(width: 16),
          FloatingActionButton(
            onPressed: navigateToAddPlayerScreen,
            child: const Icon(Icons.person_add_alt),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: navigateToPlayersScreen,
              child: const Text('All Players'),
            )
          ],
        ),
      ),
    );
  }

  void navigateToAddPlayerScreen() {
    navigateTo(to: const AddPlayerScreen());
  }

  void navigateToAddMatchScreen() {}

  void navigateToPlayersScreen() {
    navigateTo(to: const AllPlayersScreen());
  }

  void navigateTo({required Widget to}) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return to;
    }));
  }
}
