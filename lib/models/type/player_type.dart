import 'package:flutter/material.dart';

enum PlayerType {
  batsman,
  keeper,
  allRounder,
  bowler,
}

final playerTypes = [
  PlayerType.batsman,
  PlayerType.keeper,
  PlayerType.allRounder,
  PlayerType.bowler,
];

extension PlayerTypeX on PlayerType {
  String get name {
    switch (this) {
      case PlayerType.batsman:
        return 'Batsman';
      case PlayerType.keeper:
        return 'Wicket Keeper';
      case PlayerType.allRounder:
        return 'All Rounder';
      case PlayerType.bowler:
        return 'Bowler';
    }
  }

  IconData get icon {
    switch (this) {
      case PlayerType.batsman:
        return Icons.battery_full_rounded;
      case PlayerType.keeper:
        return Icons.sports_mma;
      case PlayerType.allRounder:
        return Icons.sports_cricket_sharp;
      case PlayerType.bowler:
        return Icons.sports_baseball_sharp;
    }
  }

  static PlayerType fromName({required String name}) {
    switch (name) {
      case 'Batsman':
        return PlayerType.batsman;
      case 'Wicket Keeper':
        return PlayerType.keeper;
      case 'All Rounder':
        return PlayerType.allRounder;
      case 'Bowler':
        return PlayerType.bowler;
      default:
        return PlayerType.batsman;
    }
  }
}
