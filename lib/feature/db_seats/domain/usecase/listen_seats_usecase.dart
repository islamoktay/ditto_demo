import 'package:ditto_demo/core/usecase/i_usecase.dart';
import 'package:ditto_demo/feature/db_seats/domain/repo/i_seat_db_repo.dart';

class ListenSeatsUsecase implements Usecase<void, NoParams?> {
  const ListenSeatsUsecase(this._seatRepo);
  final ISeatDBRepo _seatRepo;

  @override
  Future<void> call([_]) async {
    await _seatRepo.listenSeats();
  }
}
