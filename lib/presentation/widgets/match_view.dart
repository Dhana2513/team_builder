import 'package:flutter/material.dart';
import 'package:team_builder/constants/paddings.dart';
import 'package:team_builder/core/dbutil.dart';
import 'package:team_builder/presentation/screens/validate_teams_screen.dart';
import 'package:team_builder/presentation/screens/validated_teams_screen.dart';

import '../../models/entity/match_entity.dart';
import '../screens/match_teams_view_screen.dart';

class MatchView extends StatefulWidget {
  const MatchView({Key? key}) : super(key: key);

  @override
  _MatchViewState createState() => _MatchViewState();
}

class _MatchViewState extends State<MatchView> {
  @override
  void initState() {
    super.initState();
    DbUtil.instance.getAllMatches();
  }

  Widget listTile(MatchEntity match) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      color: Colors.white,
      child: Row(
        children: [
          InkWell(
            onTap: () {
              Navigator.of(context)
                  .pushNamed(MatchTeamsViewScreen.routeName, arguments: match);
            },
            child: Center(
              child: Text(
                match.matchName,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ),
          paddingLarge,
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  match.validated
                      ? ValidatedTeamsScreen.routeName
                      : ValidateTeamsScreen.routeName,
                  arguments: match,
                );
              },
              child: const Text('Validate')),
          paddingLarge,
          IconButton(
            onPressed: () {
              DbUtil.instance.deleteMatch(id: match.id);
            },
            icon: Icon(
              Icons.delete,
              color: Colors.grey.shade700,
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<MatchEntity>>(
      stream: DbUtil.instance.matchStream,
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return const SizedBox.shrink();
        }

        final matches = snapshot.data!;

        return Column(
          children: [
            for (int i = 0; i < matches.length; i++) listTile(matches[i])
          ],
        );
      },
    );
  }
}
