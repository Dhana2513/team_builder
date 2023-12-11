import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:team_builder/presentation/screens/add_player_screen.dart';
import 'package:team_builder/presentation/screens/all_players_screen.dart';
import 'package:team_builder/presentation/screens/create_teams_screen.dart';
import 'package:team_builder/presentation/screens/match_teams_view_screen.dart';
import 'package:team_builder/presentation/screens/validate_teams_screen.dart';
import 'package:team_builder/presentation/screens/validated_teams_screen.dart';

import 'firebase_options.dart';
import 'presentation/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Team Builder',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: HomeScreen.routeName,
      routes: {
        HomeScreen.routeName: (_) => const HomeScreen(),
        AddPlayerScreen.routeName: (_) => const AddPlayerScreen(),
        AllPlayersScreen.routeName: (_) => const AllPlayersScreen(),
        CreateTeamsScreen.routeName: (_) => const CreateTeamsScreen(),
        MatchTeamsViewScreen.routeName: (_) => const MatchTeamsViewScreen(),
        ValidateTeamsScreen.routeName: (_) => const ValidateTeamsScreen(),
        ValidatedTeamsScreen.routeName: (_) => const ValidatedTeamsScreen(),
      },
    );
  }
}
