import 'package:flutter/material.dart';
import 'package:team_builder/constants/paddings.dart';
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
    return ListTile(
      leading: Icon(player.playerType.icon),
      title: Row(
        children: [
          SizedBox(width: 150, child: Text(player.name)),
          SizedBox(width: 100, child: Text('PR : ${player.playerRating}%')),
          SizedBox(width: 100, child: Text('CR : ${player.captaincyRating}%')),
          paddingLarge,
          IconButton(
            onPressed: () => navigateToAddPlayerScreen(context: context),
            icon: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.edit),
            ),
          ),
          paddingLarge,
          IconButton(
            onPressed: deletePlayer,
            icon: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.delete),
            ),
          ),
        ],
      ),
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
