import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:team_builder/models/entity/player.dart';

class DbUtil {
  DbUtil._();

  static final instance = DbUtil._();

  final _playersCollection =
      FirebaseFirestore.instance.collection(DBKeys.players);

  Future<List<Player>> allPlayers() async {
    final snapshot = await _playersCollection.get();
    return snapshot.docs
        .map((doc) => Player.fromJson(doc.data(), id: doc.id))
        .toList();
  }

  Future updatePlayer({required String docID, required Player player}) {
    return _playersCollection.doc(docID).update(player.toJson());
  }

  Future addPlayer({required Player player}) {
    return _playersCollection.add(player.toJson());
  }

  void delete({String? id}) {
    _playersCollection.doc(id).delete();
  }
}

class DBKeys {
  static const players = 'players';
}
