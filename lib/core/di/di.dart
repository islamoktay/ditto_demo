import 'package:ditto_live/ditto_live.dart';
import 'package:get_it/get_it.dart';
import 'package:path_provider/path_provider.dart';

import 'package:ditto_demo/core/blocs/user_cubit/user_cubit.dart';
import 'package:ditto_demo/core/services/navigation_service/navigation_service.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async {
  final ditto = await _dittoInit();
  sl
    ..registerSingleton<Ditto>(ditto)
    ..registerSingleton<UserCubit>(UserCubit())
    ..registerFactory<NavigationService>(NavigationService.new);
}

Future<Ditto> _dittoInit() async {
  final identity = await OnlinePlaygroundIdentity.create(
    appID: '073b0f2b-3b0d-4a37-bccb-98e0434bb6be',
    token: 'b9d7fa9a-7999-46b2-a2dd-f1eecac613cd',
  );
  final dir = await getApplicationDocumentsDirectory();
  final ditto = await Ditto.open(
    identity: identity,
    persistenceDirectory: dir,
  );

  await ditto.startSync();
  return ditto;
}
