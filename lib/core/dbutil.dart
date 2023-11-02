import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:team_builder/models/entity/match_entity.dart';
import 'package:team_builder/models/entity/player.dart';

class DbUtil {
  DbUtil._();

  static final instance = DbUtil._();

  final _playersCollection =
      FirebaseFirestore.instance.collection(DBKeys.players);

  final _matchesCollection =
      FirebaseFirestore.instance.collection(DBKeys.matches);

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

  void addMatch({
    required String matchName,
    required List<List<Player>> selectedTeams,
  }) {
    final list = selectedTeams
        .map((list) => list.map((player) => player.toJson()).toList())
        .toList();

    _matchesCollection.add({matchName: jsonEncode(list)});
  }

  Future<List<MatchEntity>> getAllMatches() async {
    print('getAllMatches called');
    final snapshot = await _matchesCollection.get();

    print('getAllMatches snapshot : $snapshot');

    return snapshot.docs.map((doc) {
      final data = doc.data();
      final matchName = data.keys.first;
      print('getAllMatches data : data');

      final result = jsonDecode(data[matchName]);

      final matchEntry = MatchEntity.fromJson(
        id: doc.id,
        matchName: matchName,
        jsonList: result,
      );

      return matchEntry;
    }).toList();
  }
}

class DBKeys {
  static const players = 'players';
  static const matches = 'matches';
}
