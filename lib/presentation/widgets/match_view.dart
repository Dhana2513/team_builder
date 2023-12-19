import 'package:flutter/material.dart';
import 'package:team_builder/constants/paddings.dart';
import 'package:team_builder/core/dbutil.dart';
import 'package:team_builder/presentation/screens/validate_teams_screen.dart';
import 'package:team_builder/presentation/screens/validated_teams_screen.dart';

import '../../models/entity/match_entity.dart';
import '../screens/match_teams_view_screen.dart';

class MatchView extends StatefulWidget {
  const MatchView({
    Key? key,
    required this.adminModeValueNotifier,
  }) : super(key: key);

  final ValueNotifier<bool> adminModeValueNotifier;

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
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8.0),
          color: Colors.white,
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(
                    match.validated
                        ? ValidatedTeamsScreen.routeName
                        : MatchTeamsViewScreen.routeName,
                    arguments: match,
                  );
                },
                child: Container(
                  width: 200,
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    match.matchName,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ),
              ValueListenableBuilder(
                  valueListenable: widget.adminModeValueNotifier,
                  builder:
                      (BuildContext context, bool adminMode, Widget? child) {
                    return Row(
                      children: [
                        if (adminMode) ...[
                          ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pushNamed(
                                  ValidateTeamsScreen.routeName,
                                  arguments: match,
                                );
                              },
                              child: const Text('Validate')),
                          paddingLarge,
                          IconButton(
                            onPressed: () => showAlertDialog(match),
                            icon: Icon(
                              Icons.delete,
                              color: Colors.grey.shade700,
                            ),
                          )
                        ] else
                          const SizedBox.shrink(),
                      ],
                    );
                  }),
            ],
          ),
        ),
        Container(height: 2, color: Colors.grey.shade200),
      ],
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
          children: [for (final match in matches) listTile(match)],
        );
      },
    );
  }

  void showAlertDialog(MatchEntity match) {
    Widget okButton = TextButton(
      child: const Text("Delete"),
      onPressed: () {
        Navigator.of(context).pop();
        DbUtil.instance.deleteMatch(id: match.id);
      },
    );

    Widget cancelButton = TextButton(
      child: const Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Delete Match"),
      content: Text('Are you sure you want to delete : ${match.matchName}?'),
      actions: [
        okButton,
        cancelButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
