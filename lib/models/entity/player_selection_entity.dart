import 'package:team_builder/models/entity/player.dart';
import 'package:team_builder/models/type/captaincy_type.dart';
import 'package:team_builder/models/type/player_type.dart';
import 'package:team_builder/models/type/team_type.dart';

class PlayerSelectionEntity extends Player {
  PlayerSelectionEntity({
    required TeamType teamType,
    required String name,
    required PlayerType playerType,
    required int playerRating,
    required int captaincyRating,
    required bool mustHave,
    required CaptaincyType captaincyType,
    required double points,
    required double dmPoints,
  }) : super(
          teamType: teamType,
          name: name,
          playerType: playerType,
          playerRating: playerRating,
          captaincyRating: captaincyRating,
          mustHave: mustHave,
          captaincyType: captaincyType,
          points: points,
          dmPoints: dmPoints,
        );

  factory PlayerSelectionEntity.fromPlayer({required Player player}) {
    return PlayerSelectionEntity(
      teamType: player.teamType,
      name: player.name,
      playerType: player.playerType,
      playerRating: player.playerRating,
      captaincyRating: player.captaincyRating,
      mustHave: player.mustHave,
      captaincyType: player.captaincyType,
      points: player.points,
      dmPoints: player.dmPoints,
    );
  }

  int captainCount = 0;
  int viceCaptainCount = 0;
  int selectedCount = 1;
}
