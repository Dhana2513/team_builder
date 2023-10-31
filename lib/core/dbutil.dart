import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:team_builder/models/entity/player.dart';

class DbUtil {
  DbUtil._();

  static final instance = DbUtil._();

  final playersCollection =
      FirebaseFirestore.instance.collection(DBKeys.players);

  Future<List<Player>> allPlayers() async {
    final snapshot = await playersCollection.get();
    return snapshot.docs.map((doc) => Player.fromJson(doc.data())).toList();
  }
}

class DBKeys {
  static const players = 'players';
}
