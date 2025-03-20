import 'package:ditto_demo/feature/db_meal/presentation/cubit/meal_cubit.dart';
import 'package:ditto_demo/feature/db_seats/presentation/cubit/seat_cubit.dart';
import 'package:ditto_demo/feature/flight_list/domain/entity/flight.dart';
import 'package:ditto_demo/feature/home/domain/use_case/ditto_launch_usecase.dart';
import 'package:ditto_demo/feature/home/presentation/cubit/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.dittoLaunchUseCase, this.mealCubit, this.seatCubit)
      : super(HomeLoadingState());

  final DittoLaunchUsecase dittoLaunchUseCase;
  final MealCubit mealCubit;
  final SeatCubit seatCubit;

  Future<void> initiateDitto(Flight flight) async {
    await dittoLaunchUseCase.call(flight);
    await mealCubit.listenStorageMeals();
    await seatCubit.listenSeats();

    emit(
      HomeSuccessState(),
    );
  }
}
