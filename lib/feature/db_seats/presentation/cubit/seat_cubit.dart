

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ditto_demo/feature/db_meal/domain/entity/update_meal_request.dart';
import 'package:ditto_demo/feature/db_meal/domain/usecase/update_meal_from_order_usecase.dart';
import 'package:ditto_demo/feature/db_seats/domain/entity/seat.dart';
import 'package:ditto_demo/feature/db_seats/domain/usecase/get_seat_stream_usecase.dart';
import 'package:ditto_demo/feature/db_seats/domain/usecase/listen_seats_usecase.dart';
import 'package:ditto_demo/feature/db_seats/domain/usecase/take_order_usecase.dart';



class SeatCubit extends Cubit<List<Seat>> {
  SeatCubit(
    this._takeOrderUsecase,
    this._listenSeatsUsecase,
    this._getSeatStreamUsecase,
    this._updateMealFromOrderUsecase,
  ) : super(const []);

  final TakeOrderUsecase _takeOrderUsecase;
  final ListenSeatsUsecase _listenSeatsUsecase;
  final GetSeatStreamUsecase _getSeatStreamUsecase;
  final UpdateMealFromOrderUsecase _updateMealFromOrderUsecase;

  Future<void> takeOrder(Seat seat) async {
    await _takeOrderUsecase.call(seat);
    await _updateMealFromOrderUsecase(
      UpdateMealRequest(
        mealName: seat.meal,
        seatNumber: seat.seatNumber.toString(),
      ),
    );
  }

  Future<void> listenSeats() async {
    await _listenSeatsUsecase.call();
    _getSeatStreamUsecase.call().listen(
      (event) {
        if (!isClosed) emit(event);
      },
    );
  }
}
