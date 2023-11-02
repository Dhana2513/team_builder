import 'package:flutter/material.dart';
import 'package:team_builder/constants/paddings.dart';

import '../../core/widgets/common_app_bar.dart';
import '../../models/team_builder.dart';
import '../../models/type/pitch_type.dart';
import '../../models/type/team_type.dart';
import '../widgets/playing_teams.dart';

class CreateTeamsScreen extends StatefulWidget {
  const CreateTeamsScreen({Key? key}) : super(key: key);

  static const routeName = '/createTeam';

  @override
  _CreateTeamsScreenState createState() => _CreateTeamsScreenState();
}

class _CreateTeamsScreenState extends State<CreateTeamsScreen> {
  TeamType? teamType1;
  TeamType? teamType2;
  PitchType? pitchType;
  double numberOfTeams = 10;
  final averageScoreController = TextEditingController();

  Widget get teamDropDowns => Row(
        children: [
          Flexible(
            child: DropdownButtonFormField<TeamType>(
              decoration: const InputDecoration(labelText: 'Team 1'),
              value: teamType1,
              items: teams.map((TeamType value) {
                return DropdownMenuItem<TeamType>(
                  value: value,
                  child: Text(value.shortName),
                );
              }).toList(),
              onChanged: (team) {
                setState(() {
                  teamType1 = team;
                });
              },
            ),
          ),
          paddingLarge,
          const Text('Vs'),
          paddingLarge,
          Flexible(
            child: DropdownButtonFormField<TeamType>(
              decoration: const InputDecoration(labelText: 'Team 2'),
              value: teamType2,
              items: teams.map((TeamType value) {
                return DropdownMenuItem<TeamType>(
                  value: value,
                  child: Text(value.shortName),
                );
              }).toList(),
              onChanged: (team) {
                setState(() {
                  teamType2 = team;
                });
              },
            ),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: 'Build Teams',
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: ListView(
          children: [
            teamDropDowns,
            paddingExtraLarge,
            DropdownButtonFormField<PitchType>(
              decoration: const InputDecoration(labelText: 'Pitch Type'),
              value: pitchType,
              items: pitchTypes.map((PitchType value) {
                return DropdownMenuItem<PitchType>(
                  value: value,
                  child: Text(value.name),
                );
              }).toList(),
              onChanged: (type) {
                setState(() {
                  pitchType = type;
                });
              },
            ),
            paddingExtraLarge,
            TextField(
              controller: averageScoreController,
              decoration: const InputDecoration(
                labelText: 'Average Score',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            paddingExtraLarge,
            const Text('Number of teams : '),
            Slider(
              value: numberOfTeams,
              max: 100,
              divisions: 10,
              label: numberOfTeams.round().toString(),
              onChanged: (double value) {
                setState(() {
                  numberOfTeams = value;
                });
              },
            ),
            paddingExtraLarge,
            PlayingTeams(
              teamType1: teamType1,
              teamType2: teamType2,
            ),
            paddingExtraLarge,
            ElevatedButton(
              onPressed: validateAndCreateTeams,
              child: const Text('Build Teams'),
            ),
          ],
        ),
      ),
    );
  }

  void validateAndCreateTeams() {
    final averageScore = averageScoreController.text.trim();

    if (teamType1 == null ||
        teamType2 == null ||
        teamType1 == teamType2 ||
        pitchType == null ||
        averageScore.isEmpty) {
      showSnackBar(message: 'Fill all fields.');
      return;
    }

    TeamBuilder(
      teamType1: teamType1!,
      teamType2: teamType2!,
      pitchType: pitchType!,
      numberOfTeams: numberOfTeams.toInt(),
      averageScore: int.parse(averageScore),
    ).build();

    showSnackBar(message: 'Team building in progress...');

    Navigator.of(context).pop();
  }

  void showSnackBar({required String message}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }
}
