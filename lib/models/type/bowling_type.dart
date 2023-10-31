enum BowlingType {
  spin,
  pace,
  none,
}

final bowlingTypes = [
  BowlingType.spin,
  BowlingType.pace,
  BowlingType.none,
];

extension BowlingTypeX on BowlingType {
  String get name {
    switch (this) {
      case BowlingType.spin:
        return 'Spin';
      case BowlingType.pace:
        return 'Pace';
      case BowlingType.none:
        return 'None';
    }
  }

  static BowlingType fromName({required String name}) {
    switch (name) {
      case 'Spin':
        return BowlingType.spin;
      case 'Pace':
        return BowlingType.pace;
      default:
        return BowlingType.none;
    }
  }
}
