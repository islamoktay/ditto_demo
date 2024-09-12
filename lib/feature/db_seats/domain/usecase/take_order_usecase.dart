import 'package:ditto_demo/core/usecase/i_usecase.dart';
import 'package:ditto_demo/feature/db_seats/domain/entity/seat.dart';
import 'package:ditto_demo/feature/db_seats/domain/repo/i_seat_db_repo.dart';

class TakeOrderUsecase implements Usecase<void, Seat> {
  const TakeOrderUsecase(this._seatRepo);
  final ISeatDBRepo _seatRepo;

  @override
  Future<void> call(Seat param) async {
    return _seatRepo.takeOrder(param);
  }
}
