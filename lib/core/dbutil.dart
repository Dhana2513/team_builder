import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:team_builder/constants/constants.dart';
import 'package:team_builder/models/entity/match_entity.dart';
import 'package:team_builder/models/entity/player.dart';
import 'package:team_builder/models/entity/team_entity.dart';

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

  void deletePlayer({String? id}) {
    _playersCollection.doc(id).delete();
  }

  void addMatch({
    required String matchName,
    required List<TeamEntity> selectedTeams,
  }) {
    _matchesCollection.add({
      matchName:
          jsonEncode(selectedTeams.map((team) => team.toJson()).toList()),
      Constants.constants.validated: false,
    });
  }

  Future updateMatch({
    required String docID,
    required MatchEntity matchEntity,
  }) {
    final list = matchEntity.teams.map((team) => team.toJson()).toList();

    return _matchesCollection.doc(docID).update(
      {
        matchEntity.matchName: jsonEncode(list),
        Constants.constants.validated: true,
      },
    );
  }

  StreamController<List<MatchEntity>> matchStreamController =
      StreamController<List<MatchEntity>>();

  Stream<List<MatchEntity>> get matchStream => matchStreamController.stream;

  void getAllMatches() async {
    final snapshots = _matchesCollection.snapshots();

    snapshots.listen((snapshot) {
      final data = snapshot.docs.map((doc) {
        final data = doc.data();
        final matchName = data.keys
            .toList()
            .firstWhere((element) => element != Constants.constants.validated);

        final result = jsonDecode(data[matchName]);

        final matchEntry = MatchEntity.fromJson(
          id: doc.id,
          matchName: matchName,
          validated: data[Constants.constants.validated],
          jsonList: result,
        );

        return matchEntry;
      }).toList();

      matchStreamController.sink.add(data);
    });
  }

  void deleteMatch({String? id}) {
    _matchesCollection.doc(id).delete();
  }
}

class DBKeys {
  static const players = 'players';
  static const matches = 'matches';
}
