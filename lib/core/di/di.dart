import 'dart:io';

import 'package:ditto_live/ditto_live.dart';
import 'package:get_it/get_it.dart';
import 'package:path_provider/path_provider.dart';

import 'package:ditto_demo/core/blocs/user_cubit/user_cubit.dart';
import 'package:ditto_demo/core/services/navigation_service/navigation_service.dart';
import 'package:ditto_demo/feature/db_meal/data/repo/meal_db_repo.dart';
import 'package:ditto_demo/feature/db_meal/domain/repo/i_meal_db_repo.dart';
import 'package:ditto_demo/feature/db_meal/domain/usecase/add_meal_to_storage_usecase.dart';
import 'package:ditto_demo/feature/db_meal/domain/usecase/get_meal_lists.dart';
import 'package:ditto_demo/feature/db_meal/domain/usecase/get_meal_stream_usecase.dart';
import 'package:ditto_demo/feature/db_meal/domain/usecase/listen_meals_usecase.dart';
import 'package:ditto_demo/feature/db_meal/domain/usecase/update_meal_from_order_usecase.dart';
import 'package:ditto_demo/feature/db_meal/presentation/cubit/meal_cubit.dart';
import 'package:ditto_demo/feature/db_seats/data/repo/seat_db_repo.dart';
import 'package:ditto_demo/feature/db_seats/domain/repo/i_seat_db_repo.dart';
import 'package:ditto_demo/feature/db_seats/domain/usecase/get_seat_stream_usecase.dart';
import 'package:ditto_demo/feature/db_seats/domain/usecase/listen_seats_usecase.dart';
import 'package:ditto_demo/feature/db_seats/domain/usecase/take_order_usecase.dart';
import 'package:ditto_demo/feature/db_seats/presentation/cubit/seat_cubit.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async {
  final ditto = await _dittoInit();
  sl
    ..registerSingleton<Ditto>(ditto)
    ..registerSingleton<IMealDBRepo>(MealDbRepo())
    ..registerSingleton<ISeatDBRepo>(SeatDBRepo())
    ..registerSingleton<MealCubit>(
      MealCubit(
        AddMealToStorageUsecase(sl()),
        ListenMealsUsecase(sl()),
        GetMealStreamUsecase(sl()),
        const GetMealListsUsecase(),
      ),
    )
    ..registerSingleton<SeatCubit>(
      SeatCubit(
        TakeOrderUsecase(sl()),
        ListenSeatsUsecase(sl()),
        GetSeatStreamUsecase(sl()),
        UpdateMealFromOrderUsecase(sl()),
      ),
    )
    ..registerSingleton<UserCubit>(UserCubit())
    ..registerFactory<NavigationService>(NavigationService.new);
}

Future<Ditto> _dittoInit() async {
  final identity = await OnlinePlaygroundIdentity.create(
    appID: '',
    token: '',
  );

  final dataDir = await getApplicationDocumentsDirectory();
  final persistenceDirectory = Directory('${dataDir.path}/ditto');
  await persistenceDirectory.create(recursive: true);

  final ditto = await Ditto.open(
    identity: identity,
    persistenceDirectory: persistenceDirectory,
  );

  await ditto.setTransportConfig(
    TransportConfig(
      peerToPeer: PeerToPeer.all(),
    ),
  );

  await ditto.startSync();

  return ditto;
}
