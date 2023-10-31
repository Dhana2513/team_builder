enum TeamType {
  india,
  southAfrica,
  newZealand,
  australia,
  pakistan,
  afghanistan,
  sriLanka,
  nederland,
  bangladesh,
  england,
  other,
}

final teams = [
  TeamType.india,
  TeamType.southAfrica,
  TeamType.newZealand,
  TeamType.australia,
  TeamType.pakistan,
  TeamType.afghanistan,
  TeamType.sriLanka,
  TeamType.nederland,
  TeamType.bangladesh,
  TeamType.england,
  TeamType.other,
];

extension TeamTypeX on TeamType {
  String get shortName {
    switch (this) {
      case TeamType.india:
        return 'IND';
      case TeamType.southAfrica:
        return 'SA';
      case TeamType.newZealand:
        return 'NZ';
      case TeamType.australia:
        return 'AUS';
      case TeamType.pakistan:
        return 'PAK';
      case TeamType.afghanistan:
        return 'AFG';
      case TeamType.sriLanka:
        return 'SL';
      case TeamType.nederland:
        return 'NED';
      case TeamType.bangladesh:
        return 'BAN';
      case TeamType.england:
        return 'ENG';
      case TeamType.other:
        return 'other';
    }
  }

  String get longName {
    switch (this) {
      case TeamType.india:
        return 'India';
      case TeamType.southAfrica:
        return 'South Africa';
      case TeamType.newZealand:
        return 'New Zealand';
      case TeamType.australia:
        return 'Australia';
      case TeamType.pakistan:
        return 'Pakistan';
      case TeamType.afghanistan:
        return 'Afghanistan';
      case TeamType.sriLanka:
        return 'SriLanka';
      case TeamType.nederland:
        return 'Nederland';
      case TeamType.bangladesh:
        return 'Bangladesh';
      case TeamType.england:
        return 'England';
      case TeamType.other:
        return 'other';
    }
  }

  static TeamType fromName({required String name}) {
    switch (name) {
      case 'IND':
        return TeamType.india;
      case 'SA':
        return TeamType.southAfrica;
      case 'NZ':
        return TeamType.newZealand;
      case 'AUS':
        return TeamType.australia;
      case 'PAK':
        return TeamType.pakistan;
      case 'AFG':
        return TeamType.afghanistan;
      case 'SL':
        return TeamType.sriLanka;
      case 'NED':
        return TeamType.nederland;
      case 'BAN':
        return TeamType.bangladesh;
      case 'ENG':
        return TeamType.england;
      default:
        return TeamType.other;
    }
  }
//
// String get flag {
//   switch (this) {
//     case TeamType.india:
//       return 'https://www.google.com/imgres?imgurl=https%3A%2F%2Fwww.mapsofindia.com%2Fmaps%2Findia%2Findia-flag.jpg&tbnid=l14AnMEjqqH9QM&vet=12ahUKEwiTv4zk7qCCAxV8yjgGHVKZCA0QMygHegQIARB6..i&imgrefurl=https%3A%2F%2Fwww.mapsofindia.com%2Fmaps%2Findia%2Fnational-flag.htm&docid=_ClXnKUIrbOiDM&w=450&h=300&q=india%20flag&ved=2ahUKEwiTv4zk7qCCAxV8yjgGHVKZCA0QMygHegQIARB6';
//     case TeamType.southAfrica:
//       return 'https://www.google.com/imgres?imgurl=https%3A%2F%2Fcdn.britannica.com%2F27%2F4227-004-32423B42%2FFlag-South-Africa.jpg&tbnid=z5uLzPMlxxpxaM&vet=12ahUKEwiU2M367qCCAxVJbmwGHedKBz0QMygAegQIARBr..i&imgrefurl=https%3A%2F%2Fwww.britannica.com%2Ftopic%2Fflag-of-South-Africa&docid=XA9sSqfIQDLWvM&w=800&h=534&q=sa%20flag&ved=2ahUKEwiU2M367qCCAxVJbmwGHedKBz0QMygAegQIARBr';
//     case TeamType.newZealand:
//       return 'https://www.google.com/imgres?imgurl=https%3A%2F%2Fcdn.britannica.com%2F17%2F3017-004-DCC13F9D%2FFlag-New-Zealand.jpg&tbnid=02mq628dJQAynM&vet=12ahUKEwjP-MaF76CCAxUDpukKHfjIC54QMygAegQIARBr..i&imgrefurl=https%3A%2F%2Fwww.britannica.com%2Ftopic%2Fflag-of-New-Zealand&docid=ymt5JAcrhrIz1M&w=800&h=400&q=NZ%20flag&ved=2ahUKEwjP-MaF76CCAxUDpukKHfjIC54QMygAegQIARBr';
//     case TeamType.australia:
//       return 'https://www.google.com/imgres?imgurl=https%3A%2F%2Fcdn.britannica.com%2F78%2F6078-004-77AF7322%2FFlag-Australia.jpg&tbnid=0zfZwWw-vkPZiM&vet=12ahUKEwicq_OO76CCAxWT6DgGHekiC_0QMygAegQIARBr..i&imgrefurl=https%3A%2F%2Fwww.britannica.com%2Ftopic%2Fflag-of-Australia&docid=yekuC4aCZFoEOM&w=800&h=400&q=AUS%20flag&ved=2ahUKEwicq_OO76CCAxWT6DgGHekiC_0QMygAegQIARBr';
//     case TeamType.pakistan:
//       return 'https://www.google.com/imgres?imgurl=https%3A%2F%2Fcdn.britannica.com%2F46%2F3346-004-D3BDE016%2Fflag-symbolism-Pakistan-design-Islamic.jpg&tbnid=A9JWhYz5hb9dEM&vet=12ahUKEwjTzMOW76CCAxXrSGwGHQhPDjgQMygAegQIARBr..i&imgrefurl=https%3A%2F%2Fwww.britannica.com%2Ftopic%2Fflag-of-Pakistan&docid=wSV3r7f2KXYpCM&w=800&h=534&q=PAK%20flag&ved=2ahUKEwjTzMOW76CCAxXrSGwGHQhPDjgQMygAegQIARBr';
//     case TeamType.afghanistan:
//       return 'https://www.google.com/imgres?imgurl=https%3A%2F%2Fcdn.britannica.com%2F40%2F5340-004-B25ED5CF%2FFlag-Afghanistan.jpg&tbnid=1W4emniwgoEwxM&vet=12ahUKEwjp2-eg76CCAxUybmwGHeq9BqwQMygAegQIARBr..i&imgrefurl=https%3A%2F%2Fwww.britannica.com%2Ftopic%2Fflag-of-Afghanistan&docid=9QC72V8RsH-gtM&w=800&h=533&q=AFG%20flag&ved=2ahUKEwjp2-eg76CCAxUybmwGHeq9BqwQMygAegQIARBr';
//     case TeamType.sriLanka:
//       return 'https://www.google.com/imgres?imgurl=https%3A%2F%2Fcdn.britannica.com%2F13%2F4413-004-3277D2EF%2FFlag-Sri-Lanka.jpg&tbnid=3-aGlt9AVozRvM&vet=12ahUKEwj_peCn76CCAxVLe2wGHQMLBeEQMygAegQIARBp..i&imgrefurl=https%3A%2F%2Fwww.britannica.com%2Ftopic%2Fflag-of-Sri-Lanka&docid=E2EwkOj6KoDgiM&w=800&h=400&q=SL%20flag&ved=2ahUKEwj_peCn76CCAxVLe2wGHQMLBeEQMygAegQIARBp';
//     case TeamType.nederland:
//       return 'https://www.google.com/imgres?imgurl=https%3A%2F%2Fupload.wikimedia.org%2Fwikipedia%2Fcommons%2Fthumb%2F2%2F20%2FFlag_of_the_Netherlands.svg%2F1200px-Flag_of_the_Netherlands.svg.png&tbnid=JuzSr0roWmzlxM&vet=12ahUKEwi2mqOu76CCAxXIm2MGHcdkAvIQMygAegQIARBC..i&imgrefurl=https%3A%2F%2Fen.wikipedia.org%2Fwiki%2FFlag_of_the_Netherlands&docid=x9D5-LDGBceKKM&w=1200&h=800&itg=1&q=NED%20flag&ved=2ahUKEwi2mqOu76CCAxXIm2MGHcdkAvIQMygAegQIARBC';
//     case TeamType.bangladesh:
//       return 'https://www.google.com/imgres?imgurl=https%3A%2F%2Fupload.wikimedia.org%2Fwikipedia%2Fcommons%2Fthumb%2Ff%2Ff9%2FFlag_of_Bangladesh.svg%2F1200px-Flag_of_Bangladesh.svg.png&tbnid=yAzA7xzUL8M69M&vet=12ahUKEwjO9pi076CCAxV22jgGHWGyBsYQMygAegQIARBB..i&imgrefurl=https%3A%2F%2Fen.wikipedia.org%2Fwiki%2FBangladesh&docid=TzZR-95_Z3-mzM&w=1200&h=720&itg=1&q=BAN%20flag&ved=2ahUKEwjO9pi076CCAxV22jgGHWGyBsYQMygAegQIARBB';
//     case TeamType.england:
//       return 'https://www.google.com/imgres?imgurl=https%3A%2F%2Fcdn.britannica.com%2F44%2F344-004-494CC2E8%2FFlag-England.jpg&tbnid=E-hXNMVVGAyYhM&vet=12ahUKEwi8nPe776CCAxV6T2wGHfY5DrMQMygAegQIARBW..i&imgrefurl=https%3A%2F%2Fwww.britannica.com%2Ftopic%2Fflag-of-England&docid=QXGoZ3xiU2LHFM&w=800&h=532&q=ENG%20flag&ved=2ahUKEwi8nPe776CCAxV6T2wGHfY5DrMQMygAegQIARBW';
//   }
// }
}
