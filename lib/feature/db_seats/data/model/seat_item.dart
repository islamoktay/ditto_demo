import 'package:ditto_demo/feature/db_seats/domain/entity/seat.dart';

class SeatItem {
  SeatItem({
    required this.seatNumber,
    required this.meal,
    this.id,
  });

  factory SeatItem.fromMap(Map<String, dynamic> map) {
    return SeatItem(
      seatNumber: map['seatNumber'] as int,
      meal: map['meal'] as String,
      id: map['_id'] as String,
    );
  }

  factory SeatItem.fromEntity(Seat seat) {
    return SeatItem(
      seatNumber: seat.seatNumber,
      meal: seat.meal,
      id: seat.id,
    );
  }

  final String meal;
  final int seatNumber;
  final String? id;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'seatNumber': seatNumber,
      'meal': meal,
      if (id != null) '_id': id,
    };
  }

  Seat toEntity() {
    return Seat(
      id: id,
      meal: meal,
      seatNumber: seatNumber,
    );
  }
}
