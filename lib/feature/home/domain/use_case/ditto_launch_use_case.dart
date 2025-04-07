import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:ditto_demo/core/blocs/user_cubit/user_cubit.dart';
import 'package:ditto_demo/core/di/di.dart';
import 'package:ditto_demo/core/usecase/i_usecase.dart';
import 'package:ditto_demo/feature/flight_list/domain/entity/flight.dart';
import 'package:ditto_demo/feature/home/presentation/cubit/connected_devices_cubit.dart';
import 'package:ditto_live/ditto_live.dart';
import 'package:path_provider/path_provider.dart';

class DittoLaunchUseCase extends Usecase<void, Flight> {
  @override
  FutureOr<void> call(Flight params) async {
    if (!sl.isRegistered<Ditto>()) {
      const appID = 'demo';
      const token = String.fromEnvironment('TOKEN');
      const sharedKey = String.fromEnvironment('SHAREDKEY');

      await Ditto.init();

      final identity = SharedKeyIdentity(
        appID: appID,
        siteID: SiteID.fromInt(Random().nextInt(1000) + 2),
        sharedKey: sharedKey,
      );

      final dataDir = await getApplicationDocumentsDirectory();
      final persistenceDirectory = Directory('${dataDir.path}/ditto');
      await persistenceDirectory.create(recursive: true);

      final ditto = await Ditto.open(
        identity: identity,
        persistenceDirectory: persistenceDirectory.path,
      )
        ..setOfflineOnlyLicenseToken(token)
        ..updateTransportConfig((config) {
          config.setAllPeerToPeerEnabled(true);
          config.global.syncGroup = params.flightNumber;
        })
        ..deviceName = sl<UserCubit>().username
        ..startSync();

      ditto.presence.observe((graph) {
        sl<ConnectedDevicesCubit>().broadcast(
          graph.remotePeers.map(
            (peer) {
              return peer.deviceName;
            },
          ).toList(),
        );
      });

      sl.registerSingleton<Ditto>(ditto);
    } else {
      sl<Ditto>()
        ..stopSync()
        ..updateTransportConfig((config) {
          config.setAllPeerToPeerEnabled(true);
          config.global.syncGroup = params.flightNumber;
        })
        ..startSync();
    }
  }
}
