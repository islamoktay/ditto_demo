import 'package:ditto_demo/core/usecase/i_usecase.dart';
import 'package:ditto_demo/feature/db_seats/domain/entity/seat.dart';
import 'package:ditto_demo/feature/db_seats/domain/repo/i_seat_db_repo.dart';

class GetSeatStreamUsecase implements Usecase<Stream<List<Seat>>, NoParams?> {
  const GetSeatStreamUsecase(this._seatRepo);
  final ISeatDBRepo _seatRepo;

  @override
  Stream<List<Seat>> call([_]) {
    return _seatRepo.stream.stream;
  }
}
