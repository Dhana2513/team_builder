import 'package:flutter/material.dart';

enum PlayerType {
  raider,
  defender,
  allRounder,
}

final playerTypes = [
  PlayerType.raider,
  PlayerType.defender,
  PlayerType.allRounder,
];

extension PlayerTypeX on PlayerType {
  String get name {
    switch (this) {
      case PlayerType.raider:
        return 'Raider';
      case PlayerType.defender:
        return 'Defender';
      case PlayerType.allRounder:
        return 'All Rounder';
    }
  }

  IconData get icon {
    switch (this) {
      case PlayerType.raider:
        return Icons.whatshot;
      case PlayerType.defender:
        return Icons.anchor;
      case PlayerType.allRounder:
        return Icons.sports_kabaddi;
    }
  }

  static PlayerType fromName({required String name}) {
    switch (name) {
      case 'Raider':
        return PlayerType.raider;
      case 'Defender':
        return PlayerType.defender;
      case 'All Rounder':
        return PlayerType.allRounder;

      default:
        return PlayerType.allRounder;
    }
  }
}
