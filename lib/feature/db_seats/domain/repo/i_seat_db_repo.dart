import 'dart:async';

import 'package:ditto_demo/feature/db_seats/domain/entity/seat.dart';

abstract class ISeatDBRepo {
  late final StreamController<List<Seat>> stream;
  Future<void> listenSeats();
  Future<void> takeOrder(Seat seat);
  Future<void> clearDB();
}
