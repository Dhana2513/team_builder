import 'package:flutter/material.dart';
import 'package:team_builder/models/entity/player.dart';
import 'package:team_builder/models/type/player_type.dart';

class PlayerPointsRowTile extends StatefulWidget {
  const PlayerPointsRowTile({
    Key? key,
    required this.player,
  }) : super(key: key);

  final Player player;

  @override
  State<PlayerPointsRowTile> createState() => _PlayerPointsRowTileState();
}

class _PlayerPointsRowTileState extends State<PlayerPointsRowTile> {
  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
      fontSize: 13,
      color: Colors.black87,
    );

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                widget.player.playerType.icon,
                color: Colors.black54,
              ),
              Text(
                widget.player.name,
                style: textStyle.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: 100,
                height: 50,
                child: TextField(
                  onChanged: (points) {
                    widget.player.points = double.parse(points);
                  },
                  decoration: const InputDecoration(
                    labelText: 'Points',
                    border: OutlineInputBorder(),
                    filled: true,
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 1,
          color: Colors.grey.shade400,
        )
      ],
    );
  }
}
