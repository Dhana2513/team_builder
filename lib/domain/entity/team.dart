import 'package:team_builder/domain/entity/player.dart';

class Team {
  final List<Player> batsmans;
  final List<Player> wicketKeepers;
  final List<Player> allRounders;
  final List<Player> bowlers;

  Team({
    required this.batsmans,
    required this.wicketKeepers,
    required this.allRounders,
    required this.bowlers,
  });
}
