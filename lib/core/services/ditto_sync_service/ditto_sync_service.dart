import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';

class DittoSyncService {
  SyncRoom joinRoom(String roomName, String username) {
    return SyncRoom(roomName, username);
  }
}

class SyncUser {
  SyncUser(this.username, this.isActive);

  final String username;
  final bool isActive;

  SyncUser copyWith({
    bool? isActive,
  }) {
    return SyncUser(username, isActive ?? this.isActive);
  }
}

class Result {
  Result({this.items = const []});

  final List<Map<String, dynamic>> items;
}

class SyncRoom {
  SyncRoom(this.roomName, this.username) {
    userStream = ValueNotifier<List<SyncUser>>([]);
  }

  static const int pingPeriod = 1000;
  static const int liveCheckPeriod = 3000;

  final String roomName;
  final String username;

  late final ValueNotifier<Iterable<SyncUser>> userStream;

  Timer? pingTimer;

  String get _currentIsoTime => DateTime.now().toIso8601String();

  Future<void> joinRoom() async {
    try {
      await execute(
        'INSERT INTO users DOCUMENTS (:user)',
        arguments: {
          'user': {
            'username': username,
            'roomName': roomName,
            'lastUpdate': _currentIsoTime,
          },
        },
      );

      // Update lastUpdate of user record to notify others about availability
      // And get last updated users
      pingTimer =
          Timer.periodic(const Duration(milliseconds: pingPeriod), (e) async {
        await execute(
          '''
          UPDATE users
          SET lastUpdate = ':lastUpdate'
          WHERE userName = ':username' AND roomName = ':roomName'
          ''',
          arguments: {
            'username': username,
            'roomName': roomName,
            'lastUpdate': _currentIsoTime,
          },
        );

        // Fetch updated users
        final userRecords = await execute(
          '''
          SELECT username FROM users 
          WHERE roomName = :roomName
          ''',
          arguments: {
            'roomName': roomName,
          },
        );

        final userList = userRecords.items.map((record) {
          final username = record['username'] as String?;

          final lastUpdateTime = DateTime.parse(
            record['lastUpdate'] as String? ?? '',
          );

          final isActive = lastUpdateTime.compareTo(
                DateTime.now()
                    .subtract(const Duration(milliseconds: liveCheckPeriod)),
              ) ==
              1;

          return SyncUser(
            username ?? '#Error',
            isActive,
          );
        });

        userStream.value = userList;
      });
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> insertDocs(
    String collectionName,
    List<Map<String, dynamic>> documents,
  ) async {
    final docDefs = <String>[];
    final docArgs = <String, dynamic>{};

    var mapDefs = <String>[];

    for (final indexedDocs in documents.indexed) {
      final index = indexedDocs.$1;
      final docMap = indexedDocs.$2;
      final arg = 'doc$index';

      if (index == 0) {
        mapDefs = getMapDefs(docMap);
      }

      docDefs.add('(:$arg)');

      // Extend document with room management fields
      docArgs[arg] = {
        'roomName': roomName,
        'createdAt': _currentIsoTime,
        'updatedAt': _currentIsoTime,
        'deleted': false,
        ...docMap,
      };
    }

    final mapDefString = mapDefs.isNotEmpty ? "(${mapDefs.join(", ")})" : '';

    await execute(
      'INSERT INTO :collectionName $mapDefString DOCUMENTS ${docDefs.join(", ")}',
      arguments: {
        'collectionName': collectionName,
        ...docArgs,
      },
    );
  }

  Future<void> updateDocs(
    String collectionName,
    List<Map<String, dynamic>> documents,
    String whereString,
  ) async {
    final docDefs = <String>[];
    final docArgs = <String, dynamic>{};

    var mapDefs = <String>[];

    for (final indexedDocs in documents.indexed) {
      final index = indexedDocs.$1;
      final docMap = indexedDocs.$2;
      final arg = 'doc$index';

      if (index == 0) {
        mapDefs = getMapDefs(docMap);
      }

      docDefs.add('(:$arg)');

      // Extend document with room management fields
      docArgs[arg] = {
        'roomName': roomName,
        'createdAt': _currentIsoTime,
        'updatedAt': _currentIsoTime,
        'deleted': false,
        ...docMap,
      };
    }

    final mapDefString = mapDefs.isNotEmpty ? "(${mapDefs.join(", ")})" : '';

    await execute(
      'UPDATE INTO :collectionName $mapDefString DOCUMENTS ${docDefs.join(", ")}',
      arguments: {
        'collectionName': collectionName,
        ...docArgs,
      },
    );
  }

  Future<Result> execute(String dql, {Map<String, dynamic>? arguments}) async {
    debugPrint('Dql: $dql');
    debugPrint('Args: $arguments');
    return Result();
  }

  List<String> getMapDefs(Map<String, dynamic> doc) {
    final mapDefs = <String>[];

    for (final entry in doc.entries) {
      if (entry.value is Map) {
        final nestedMapDefs = getMapDefs(entry.value as Map<String, dynamic>);

        final mapDefString =
            mapDefs.isNotEmpty ? "(${nestedMapDefs.join(", ")})" : '';

        mapDefs.add('${entry.key} MAP$mapDefString');
      }
    }

    return mapDefs;
  }

  Future<void> dispose() async {}
}
