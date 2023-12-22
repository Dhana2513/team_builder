import 'package:flutter/material.dart';
import 'package:team_builder/models/type/captaincy_type.dart';
import 'package:team_builder/models/type/player_type.dart';
import 'package:team_builder/models/type/team_type.dart';

import '../../core/dbutil.dart';
import '../../models/entity/player.dart';
import '../screens/add_player_screen.dart';

class PlayerTable extends StatefulWidget {
  const PlayerTable({
    Key? key,
    required this.players,
    this.onPlayerUpdate,
  }) : super(key: key);

  final List<Player> players;
  final VoidCallback? onPlayerUpdate;

  @override
  _PlayerTableState createState() => _PlayerTableState();
}

class _PlayerTableState extends State<PlayerTable> {
  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
      fontSize: 13,
      color: Colors.black87,
    );

    return Table(
      columnWidths: widget.onPlayerUpdate != null
          ? const {
              0: FlexColumnWidth(2),
              1: FlexColumnWidth(3),
              2: FlexColumnWidth(1),
              3: FlexColumnWidth(1),
              4: FlexColumnWidth(1),
              5: FlexColumnWidth(2),
              6: FlexColumnWidth(2),
              7: FlexColumnWidth(2),
            }
          : const {
              0: FlexColumnWidth(2),
              1: FlexColumnWidth(3),
              2: FlexColumnWidth(2),
              3: FlexColumnWidth(2),
            },
      children: [
        TableRow(children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 24),
            child: Text(''),
          ),
          Text('Name', style: textStyle.copyWith(fontWeight: FontWeight.w600)),
          if (widget.onPlayerUpdate != null) ...[
            Text('DP', style: textStyle.copyWith(fontWeight: FontWeight.w600)),
            Text('PR', style: textStyle.copyWith(fontWeight: FontWeight.w600)),
            Text('CR', style: textStyle.copyWith(fontWeight: FontWeight.w600)),
            Text('Must',
                style: textStyle.copyWith(fontWeight: FontWeight.w600)),
            const Text(' '),
            const Text(''),
          ] else ...[
            Text('Team',
                style: textStyle.copyWith(fontWeight: FontWeight.w600)),
            Text('Points',
                style: textStyle.copyWith(fontWeight: FontWeight.w600)),
          ],
        ]),
        for (final player in widget.players)
          TableRow(
            children: [
              Icon(
                player.playerType.icon,
                color: Colors.black54,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: Text(
                  '${player.name} ${player.captaincyType.shortName}',
                  style: textStyle.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              if (widget.onPlayerUpdate != null) ...[
                Text('${player.dmPoints}', style: textStyle),
                Text('${player.playerRating}', style: textStyle),
                Text('${player.captaincyRating}', style: textStyle),
                Switch(
                  value: player.mustHave,
                  onChanged: (value) {
                    setState(() {
                      player.mustHave = value;
                    });
                    updatePlayerStatus(player);
                  },
                ),
                IconButton(
                  onPressed: () => navigateToAddPlayerScreen(
                    context: context,
                    player: player,
                  ),
                  icon: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.edit,
                      color: Colors.black54,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => deletePlayer(player),
                  icon: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.delete,
                      color: Colors.black54,
                    ),
                  ),
                ),
              ] else ...[
                Text(
                  player.teamType.shortName,
                  style: textStyle,
                ),
                Text(
                  '${player.points == 0 ? '' : player.points}',
                  style: textStyle,
                ),
              ],
            ],
          ),
      ],
    );
  }

  void navigateToAddPlayerScreen({
    required BuildContext context,
    required Player player,
  }) async {
    final refresh = await Navigator.of(context).pushNamed(
      AddPlayerScreen.routeName,
      arguments: player,
    );

    if (refresh is bool?) {
      if (refresh == true) {
        widget.onPlayerUpdate?.call();
      }
    }
  }

  void deletePlayer(Player player) {
    DbUtil.instance.deletePlayer(id: player.id);
    widget.onPlayerUpdate?.call();
  }

  void updatePlayerStatus(Player player) {
    DbUtil.instance.updatePlayer(docID: player.id!, player: player);
  }
}
