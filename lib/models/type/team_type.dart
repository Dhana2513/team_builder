enum TeamType {
  gujaratGiants,
  uMumba,
  tamilThalaivas,
  puneriPaltan,
  bengalWarriors,
  bengaluruBulls,
  upYodhas,
  jaipurPinkPanthers,
  telguTitans,
  haryanaSteelers,
  patnaPirates,
  dabangDelhi,
}

final teams = [
  TeamType.gujaratGiants,
  TeamType.uMumba,
  TeamType.tamilThalaivas,
  TeamType.puneriPaltan,
  TeamType.bengalWarriors,
  TeamType.bengaluruBulls,
  TeamType.upYodhas,
  TeamType.jaipurPinkPanthers,
  TeamType.telguTitans,
  TeamType.haryanaSteelers,
  TeamType.patnaPirates,
  TeamType.dabangDelhi,
];

extension TeamTypeX on TeamType {
  String get shortName {
    switch (this) {
      case TeamType.gujaratGiants:
        return 'GUJ';
      case TeamType.uMumba:
        return 'MUM';
      case TeamType.tamilThalaivas:
        return 'TAM';
      case TeamType.puneriPaltan:
        return 'PUN';
      case TeamType.bengalWarriors:
        return 'B_WAR';
      case TeamType.bengaluruBulls:
        return 'B_BUL';
      case TeamType.upYodhas:
        return 'UP';
      case TeamType.jaipurPinkPanthers:
        return 'JAI';
      case TeamType.telguTitans:
        return 'TEL';
      case TeamType.haryanaSteelers:
        return 'HAR';
      case TeamType.patnaPirates:
        return 'PAT';
      case TeamType.dabangDelhi:
        return 'DEL';
    }
  }

  String get longName {
    switch (this) {
      case TeamType.gujaratGiants:
        return 'GujaratGiants';
      case TeamType.uMumba:
        return 'U Mumba';
      case TeamType.tamilThalaivas:
        return 'Tamil Thalaivas';
      case TeamType.puneriPaltan:
        return 'Puneri Paltan';
      case TeamType.bengalWarriors:
        return 'Bengal Warriors';
      case TeamType.bengaluruBulls:
        return 'BengaluruBulls';
      case TeamType.upYodhas:
        return 'UP Yodhas ';
      case TeamType.jaipurPinkPanthers:
        return 'Jaipur Pink Panthers';
      case TeamType.telguTitans:
        return 'Telgu Titans';
      case TeamType.haryanaSteelers:
        return 'Heryana Steelers';
      case TeamType.patnaPirates:
        return 'Patna Pirates';
      case TeamType.dabangDelhi:
        return 'Dabang Delhi';
    }
  }

  static TeamType fromName({required String name}) {
    switch (name) {
      case 'GUJ':
        return TeamType.gujaratGiants;
      case 'MUM':
        return TeamType.uMumba;
      case 'TAM':
        return TeamType.tamilThalaivas;
      case 'PUN':
        return TeamType.puneriPaltan;
      case 'B_WAR':
        return TeamType.bengalWarriors;
      case 'B_BUL':
        return TeamType.bengaluruBulls;
      case 'UP':
        return TeamType.upYodhas;
      case 'JAI':
        return TeamType.jaipurPinkPanthers;
      case 'TEL':
        return TeamType.telguTitans;
      case 'HAR':
        return TeamType.haryanaSteelers;
      case 'PAT':
        return TeamType.patnaPirates;
      case 'DEL':
        return TeamType.dabangDelhi;
      default:
        return TeamType.gujaratGiants;
    }
  }
}
