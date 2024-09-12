import 'dart:async';

import 'package:ditto_live/ditto_live.dart';

import 'package:ditto_demo/core/di/di.dart';
import 'package:ditto_demo/feature/db_seats/data/model/seat_item.dart';
import 'package:ditto_demo/feature/db_seats/domain/entity/seat.dart';
import 'package:ditto_demo/feature/db_seats/domain/repo/i_seat_db_repo.dart';

class SeatDBRepo implements ISeatDBRepo {
  SeatDBRepo() {
    stream = StreamController<List<Seat>>.broadcast();
  }

  @override
  late final StreamController<List<Seat>> stream;

  @override
  Future<void> takeOrder(Seat seat) async {
    await sl<Ditto>().store.execute(
      'INSERT INTO seats DOCUMENTS (:seat)',
      arguments: {'seat': SeatItem.fromEntity(seat).toMap()},
    );
  }

  @override
  Future<void> listenSeats() async {
    final result = await sl<Ditto>().store.execute('SELECT * FROM seats');

    final meals =
        result.items.map((e) => SeatItem.fromMap(e.value).toEntity()).toList();

    stream.add(meals);

    await sl<Ditto>().store.registerObserver(
      'SELECT * FROM seats',
      onChange: (val) {
        final list =
            val.items.map((e) => SeatItem.fromMap(e.value).toEntity()).toList();
        stream.add(list);
      },
    );
  }

  @override
  Future<void> clearDB() async {
    for (var i = 1; i <= 15; i++) {
      await sl<Ditto>().store.execute('EVICT FROM seats WHERE seatNumber = $i');
    }
  }
}
