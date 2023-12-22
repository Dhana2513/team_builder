import 'package:flutter/material.dart';

import '../../constants/paddings.dart';
import '../../core/dbutil.dart';
import '../../core/widgets/common_app_bar.dart';
import '../../models/entity/player.dart';
import '../../models/type/player_type.dart';
import '../../models/type/team_type.dart';

class AddPlayerScreen extends StatefulWidget {
  const AddPlayerScreen({Key? key}) : super(key: key);

  static const routeName = '/addPlayer';

  @override
  _AddPlayerScreenState createState() => _AddPlayerScreenState();
}

class _AddPlayerScreenState extends State<AddPlayerScreen> {
  TeamType? teamType;
  PlayerType? playerType;
  TextEditingController playerNameController = TextEditingController();
  TextEditingController dmPointsController = TextEditingController();
  double playerRating = 0;
  double captaincyRating = 0;

  bool get modifyPlayer {
    return player != null;
  }

  Player? player;
  bool mustHave = false;

  void setValues(BuildContext context) {
    player = ModalRoute.of(context)!.settings.arguments as Player?;
    if (modifyPlayer) {
      playerNameController.text = player!.name;
      teamType = player!.teamType;
      playerType = player!.playerType;
      captaincyRating = player!.captaincyRating.toDouble();
      playerRating = player!.playerRating.toDouble();
      mustHave = player!.mustHave;
      dmPointsController.text = player!.dmPoints.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (player == null) {
      setValues(context);
    }

    return Scaffold(
      appBar: CommonAppBar(
        title: 'Add Player',
      ),
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
            paddingLarge,
            TextField(
              controller: playerNameController,
              decoration: const InputDecoration(
                labelText: 'Player Name',
                border: OutlineInputBorder(),
                filled: true,
              ),
              textCapitalization: TextCapitalization.sentences,
              keyboardType: TextInputType.name,
            ),
            paddingLarge,
            TextField(
              controller: dmPointsController,
              decoration: const InputDecoration(
                labelText: 'Dream11 Points',
                border: OutlineInputBorder(),
                filled: true,
              ),
              textCapitalization: TextCapitalization.sentences,
              keyboardType: TextInputType.number,
            ),
            paddingLarge,
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
            paddingLarge,
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
            paddingLarge,
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
            paddingLarge,
            Row(
              children: [
                const Text('Must Have'),
                padding,
                Switch(
                  value: mustHave,
                  onChanged: (value) {
                    setState(() {
                      mustHave = value;
                    });
                  },
                )
              ],
            ),
            paddingLarge,
            ElevatedButton(
              onPressed: validateAndSubmit,
              child: Text(modifyPlayer ? 'Update' : 'Add'),
            )
          ],
        ),
      ),
    );
  }

  void validateAndSubmit() {
    final playerName = playerNameController.text.trim();
    final dmPoints = dmPointsController.text.trim();

    if (teamType == null ||
        playerName.isEmpty ||
        dmPoints.isEmpty ||
        playerType == null) {
      showSnackBar(message: 'Fill all fields');
      return;
    } else {
      final player = Player(
        teamType: teamType!,
        name: playerName,
        playerType: playerType!,
        playerRating: playerRating.toInt(),
        mustHave: mustHave,
        captaincyRating: captaincyRating.toInt(),
        dmPoints: double.parse(dmPoints),
      );

      if (modifyPlayer) {
        DbUtil.instance
            .updatePlayer(docID: this.player!.id!, player: player)
            .then((_) {
          showSnackBar(message: 'Record modified');
          Navigator.of(context).pop(true);
        });
      } else {
        DbUtil.instance.addPlayer(player: player);

        setState(() {
          playerNameController.text = '';
          mustHave = false;
        });

        showSnackBar(message: 'Record added');
      }
    }
  }

  void showSnackBar({required String message}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }
}
