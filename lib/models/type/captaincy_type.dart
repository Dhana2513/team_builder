enum CaptaincyType {
  captain,
  viceCaptain,
  none,
}

extension CaptaincyTypeX on CaptaincyType {
  String get name {
    switch (this) {
      case CaptaincyType.captain:
        return 'captain';
      case CaptaincyType.viceCaptain:
        return 'viceCaptain';

      default:
        return 'none';
    }
  }

  String get shortName {
    switch (this) {
      case CaptaincyType.captain:
        return '(C)';
      case CaptaincyType.viceCaptain:
        return '(Vc)';

      default:
        return '';
    }
  }

  static CaptaincyType fromName({required String? name}) {
    switch (name) {
      case 'captain':
        return CaptaincyType.captain;
      case 'viceCaptain':
        return CaptaincyType.viceCaptain;

      default:
        return CaptaincyType.none;
    }
  }
}
