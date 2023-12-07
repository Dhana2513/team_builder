import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:team_builder/models/entity/match_entity.dart';
import 'package:team_builder/models/entity/player.dart';

import '../models/type/captaincy_type.dart';

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
    required List<List<Player>> selectedTeams,
  }) {
    print('ddd addMatch $matchName');
    print('ddd selectedTeams $selectedTeams');

    final random = Random();

    Player selectCaptain({required List<Player> team}) {
      final players = [...team];
      final List<Player> allPlayers = [];
      players.removeWhere((player) => player.captaincyRating <= 20);

      for (final player in players) {
        for (int i = 1; i < player.captaincyRating; i += 10) {
          allPlayers.add(player);
        }
      }

      return allPlayers[random.nextInt(allPlayers.length)];
    }

    final list = selectedTeams.map((team) {
      final captain = selectCaptain(team: team);
      Player viceCaptain = selectCaptain(team: team);

      while (captain == viceCaptain) {
        viceCaptain = selectCaptain(team: team);
      }

      captain.captaincyType = CaptaincyType.captain;
      viceCaptain.captaincyType = CaptaincyType.viceCaptain;

      final json = team.map((player) => player.toJson()).toList();

      captain.captaincyType = CaptaincyType.none;
      viceCaptain.captaincyType = CaptaincyType.none;

      return json;
    }).toList();

    _matchesCollection.add({matchName: jsonEncode(list)});
  }

  final matchStreamController = StreamController<List<MatchEntity>>();

  Stream<List<MatchEntity>> get matchStream => matchStreamController.stream;

  void getAllMatches() async {
    final snapshots = _matchesCollection.snapshots();

    snapshots.listen((snapshot) {
      final data = snapshot.docs.map((doc) {
        final data = doc.data();
        final matchName = data.keys.first;

        final result = jsonDecode(data[matchName]);

        final matchEntry = MatchEntity.fromJson(
          id: doc.id,
          matchName: matchName,
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
