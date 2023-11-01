import 'package:flutter/material.dart';
import 'package:team_builder/core/dbutil.dart';
import 'package:team_builder/models/entity/player.dart';
import 'package:team_builder/models/type/player_type.dart';
import 'package:team_builder/presentation/screens/add_player_screen.dart';

class PlayerRowTile extends StatelessWidget {
  const PlayerRowTile({
    Key? key,
    required this.player,
    required this.onPlayerUpdate,
  }) : super(key: key);

  final Player player;
  final VoidCallback onPlayerUpdate;

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
          player.playerType.icon,
          color: Colors.black54,
        ),
        Text(
          player.name,
          style: textStyle.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'PR : ${player.playerRating}%',
          style: textStyle,
        ),
        Text(
          'CR : ${player.captaincyRating}%',
          style: textStyle,
        ),
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
    );
  }

  void navigateToAddPlayerScreen({required BuildContext context}) async {
    final refresh = await Navigator.of(context).pushNamed(
      AddPlayerScreen.routeName,
      arguments: player,
    );

    if (refresh is bool?) {
      if (refresh == true) {
        onPlayerUpdate.call();
      }
    }
  }

  void deletePlayer() {
    DbUtil.instance.delete(id: player.id);
    onPlayerUpdate.call();
  }
}
