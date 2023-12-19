import 'package:flutter/material.dart';
import 'package:team_builder/constants/paddings.dart';
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
      width: 200,
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

  final adminModeValueNotifier = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: 'Team Builder',
        onTap: () {
          clickCount++;
          adminModeValueNotifier.value = clickCount >= 5;
        },
      ),
      body: Container(
        color: Colors.white10,
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            ValueListenableBuilder(
                valueListenable: adminModeValueNotifier,
                builder: (BuildContext context, bool adminMode, Widget? child) {
                  return SizedBox(
                    width: 300,
                    child: Column(
                      children: [
                        if (adminMode) ...[
                          navigationButton(
                            title: 'All Players',
                            routeName: AllPlayersScreen.routeName,
                          ),
                          navigationButton(
                            title: 'Create Teams',
                            routeName: CreateTeamsScreen.routeName,
                          ),
                          paddingLarge,
                        ] else
                          const SizedBox(
                            width: 200,
                            height: 16,
                          ),
                      ],
                    ),
                  );
                }),
            MatchView(adminModeValueNotifier: adminModeValueNotifier),
          ],
        ),
      ),
    );
  }

  void navigateTo({required String routeName}) {
    Navigator.of(context).pushNamed(routeName);
  }
}
