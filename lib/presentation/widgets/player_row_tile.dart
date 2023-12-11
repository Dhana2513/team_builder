import 'package:flutter/material.dart';
import 'package:team_builder/core/dbutil.dart';
import 'package:team_builder/models/entity/player.dart';
import 'package:team_builder/models/type/captaincy_type.dart';
import 'package:team_builder/models/type/player_type.dart';
import 'package:team_builder/presentation/screens/add_player_screen.dart';

class PlayerRowTile extends StatefulWidget {
  const PlayerRowTile({
    Key? key,
    required this.player,
    this.onPlayerUpdate,
  }) : super(key: key);

  final Player player;
  final VoidCallback? onPlayerUpdate;

  @override
  State<PlayerRowTile> createState() => _PlayerRowTileState();
}

class _PlayerRowTileState extends State<PlayerRowTile> {
  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
      fontSize: 13,
      color: Colors.black87,
    );

    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Icon(
          widget.player.playerType.icon,
          color: Colors.black54,
        ),
        Text(
          '${widget.player.name} ${widget.player.captaincyType.shortName}',
          style: textStyle.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'PR : ${widget.player.playerRating}%',
          style: textStyle,
        ),
        Text(
          'CR : ${widget.player.captaincyRating}%',
          style: textStyle,
        ),
        Row(
          children: [
            const Text('Must Have'),
            Switch(
                value: widget.player.mustHave,
                onChanged: (value) {
                  setState(() {
                    widget.player.mustHave = value;
                  });
                  updatePlayerStatus();
                })
          ],
        ),
        if (widget.onPlayerUpdate != null) ...[
          IconButton(
            onPressed: () => navigateToAddPlayerScreen(context: context),
            icon: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.edit,
                color: Colors.black54,
              ),
            ),
          ),
          IconButton(
            onPressed: deletePlayer,
            icon: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.delete,
                color: Colors.black54,
              ),
            ),
          ),
        ],
      ],
    );
  }

  void navigateToAddPlayerScreen({required BuildContext context}) async {
    final refresh = await Navigator.of(context).pushNamed(
      AddPlayerScreen.routeName,
      arguments: widget.player,
    );

    if (refresh is bool?) {
      if (refresh == true) {
        widget.onPlayerUpdate?.call();
      }
    }
  }

  void deletePlayer() {
    DbUtil.instance.deletePlayer(id: widget.player.id);
    widget.onPlayerUpdate?.call();
  }

  void updatePlayerStatus() {
    DbUtil.instance
        .updatePlayer(docID: widget.player.id!, player: widget.player);
  }
}
