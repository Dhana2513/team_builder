import 'package:flutter/material.dart';

import '../constants/paddings.dart';
import '../core/dbutil.dart';
import '../models/entity/player.dart';
import '../models/type/bowling_type.dart';
import '../models/type/player_type.dart';
import '../models/type/team_type.dart';

class AddPlayerScreen extends StatefulWidget {
  const AddPlayerScreen({Key? key}) : super(key: key);

  @override
  _AddPlayerScreenState createState() => _AddPlayerScreenState();
}

class _AddPlayerScreenState extends State<AddPlayerScreen> {
  TeamType? teamType;
  PlayerType? playerType;
  BowlingType? bowlingType;
  TextEditingController playerNameController = TextEditingController();
  double playerRating = 0;
  double captaincyRating = 0;

  bool get canBowl =>
      [PlayerType.allRounder, PlayerType.bowler].contains(playerType);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            DropdownButtonFormField<TeamType>(
              decoration: const InputDecoration(labelText: 'Team'),
              value: teamType,
              items: teams.map((TeamType value) {
                return DropdownMenuItem<TeamType>(
                  value: value,
                  child: Text(value.shortName),
                );
              }).toList(),
              onChanged: (team) {
                setState(() {
                  teamType = team;
                });
              },
            ),
            largePadding,
            TextField(
              controller: playerNameController,
              decoration: const InputDecoration(
                labelText: 'Player Name',
                border: OutlineInputBorder(),
                filled: true,
              ),
            ),
            largePadding,
            DropdownButtonFormField<PlayerType>(
              decoration: const InputDecoration(labelText: 'Player Type'),
              value: playerType,
              items: playerTypes.map((PlayerType value) {
                return DropdownMenuItem<PlayerType>(
                  value: value,
                  child: Text(value.name),
                );
              }).toList(),
              onChanged: (type) {
                setState(() {
                  playerType = type;
                });
              },
            ),
            largePadding,
            if (canBowl) ...[
              DropdownButtonFormField<BowlingType>(
                decoration: const InputDecoration(labelText: 'Bowling Type'),
                value: bowlingType,
                items: bowlingTypes.map((BowlingType value) {
                  return DropdownMenuItem<BowlingType>(
                    value: value,
                    child: Text(value.name),
                  );
                }).toList(),
                onChanged: (type) {
                  setState(() {
                    bowlingType = type;
                  });
                },
              ),
              largePadding,
            ],
            const Text('Player Ratting'),
            Slider(
              value: playerRating,
              max: 100,
              divisions: 10,
              label: playerRating.round().toString(),
              onChanged: (double value) {
                setState(() {
                  playerRating = value;
                });
              },
            ),
            largePadding,
            const Text('Captaincy Ratting'),
            Slider(
              value: captaincyRating,
              max: 100,
              divisions: 10,
              label: captaincyRating.round().toString(),
              onChanged: (double value) {
                setState(() {
                  captaincyRating = value;
                });
              },
            ),
            largePadding,
            ElevatedButton(
              onPressed: validateAndSubmit,
              child: const Text('Add'),
            )
          ],
        ),
      ),
    );
  }

  void validateAndSubmit() {
    final playerName = playerNameController.text.trim();
    if (teamType == null ||
        playerName.isEmpty ||
        playerType == null ||
        (canBowl && bowlingType == null)) {
      showSnackBar(message: 'Fill all fields');
      return;
    } else {
      final player = Player(
        teamType: teamType!,
        name: playerName,
        playerType: playerType!,
        bowlingType: bowlingType ?? BowlingType.none,
        playerRating: playerRating.toInt(),
        captaincyRating: captaincyRating.toInt(),
      );

      DbUtil.instance.playersCollection.add(player.toJson());

      setState(() {
        playerNameController.text = '';
      });

      showSnackBar(message: 'Record added');
    }
  }

  void showSnackBar({required String message}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }
}
