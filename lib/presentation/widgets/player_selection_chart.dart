import 'package:flutter/material.dart';
import 'package:team_builder/models/entity/player_selection_entity.dart';
import 'package:team_builder/models/entity/team_entity.dart';
import 'package:team_builder/models/type/player_type.dart';
import 'package:team_builder/models/type/team_type.dart';

class PlayerSelectionChart extends StatelessWidget {
  const PlayerSelectionChart({
    Key? key,
    required this.teams,
    this.showPoints = false,
  }) : super(key: key);

  final List<TeamEntity> teams;
  final bool showPoints;

  List<PlayerSelectionEntity> get _players {
    final List<PlayerSelectionEntity> selectedPlayers = [];
    for (final team in teams) {
      for (final teamPlayer in team.players) {
        bool foundPlayer = false;

        for (final player in selectedPlayers) {
          foundPlayer = teamPlayer.isSame(player: player);

          if (foundPlayer) {
            player.selectedCount++;
            if (teamPlayer.isCaptain) {
              player.captainCount++;
            } else if (teamPlayer.isViceCaptain) {
              player.viceCaptainCount++;
            }

            break;
          }
        }

        if (!foundPlayer) {
          selectedPlayers.add(
            PlayerSelectionEntity.fromPlayer(player: teamPlayer),
          );
        }
      }
    }

    selectedPlayers.sort((a, b) => a.selectedCount > b.selectedCount ? 0 : 1);

    return selectedPlayers;
  }

  @override
  Widget build(BuildContext context) {
    final List<PlayerSelectionEntity> players = _players;

    const textStyle = TextStyle(
      fontSize: 13,
      color: Colors.black87,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        border: const TableBorder(
            bottom: BorderSide(), horizontalInside: BorderSide()),
        columnWidths: {
          0: const FlexColumnWidth(2),
          1: const FlexColumnWidth(3),
          2: const FlexColumnWidth(2),
          3: const FlexColumnWidth(2),
          4: const FlexColumnWidth(2),
          5: const FlexColumnWidth(2),
          if (showPoints) 6: const FlexColumnWidth(2),
          // 7: FlexColumnWidth(2),
          // 8: FlexColumnWidth(2),
        },
        children: [
          TableRow(children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 24),
              child: Text(''),
            ),
            Text('Name',
                style: textStyle.copyWith(fontWeight: FontWeight.w600)),
            // Text('PR', style: textStyle.copyWith(fontWeight: FontWeight.w600)),
            // Text('CR', style: textStyle.copyWith(fontWeight: FontWeight.w600)),
            Text('Team',
                style: textStyle.copyWith(fontWeight: FontWeight.w600)),
            Text('Selected By',
                style: textStyle.copyWith(fontWeight: FontWeight.w600)),
            Text('C By',
                style: textStyle.copyWith(fontWeight: FontWeight.w600)),
            Text('Vc By',
                style: textStyle.copyWith(fontWeight: FontWeight.w600)),
            if (showPoints)
              Text('Points',
                  style: textStyle.copyWith(fontWeight: FontWeight.w600)),
          ]),
          for (final player in players)
            TableRow(
              children: [
                Icon(
                  player.playerType.icon,
                  color: Colors.black54,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    player.name,
                    style: textStyle.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // Text('${player.playerRating}', style: textStyle),
                // Text('${player.captaincyRating}', style: textStyle),
                Text(player.teamType.shortName, style: textStyle),
                Text(player.selectedCount.toString(), style: textStyle),
                Text(player.captainCount.toString(), style: textStyle),
                Text(player.viceCaptainCount.toString(), style: textStyle),
                if (showPoints)
                  Text(
                    '${player.points}',
                    style: textStyle,
                  ),
              ],
            ),
        ],
      ),
    );
  }
}
