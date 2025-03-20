import 'dart:async';
import 'dart:io';

import 'package:ditto_demo/core/di/di.dart';
import 'package:ditto_demo/core/usecase/i_usecase.dart';
import 'package:ditto_demo/feature/flight_list/domain/entity/flight.dart';
import 'package:ditto_live/ditto_live.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

class DittoLaunchUsecase extends Usecase<void, Flight> {
  @override
  FutureOr<void> call(Flight params) async {
    await Ditto.init();

    const appID = 'DeMO';
    const token = String.fromEnvironment('TOKEN');

    final identity = OfflinePlaygroundIdentity(
      appID: appID,
      siteID: SiteID.fromInt(params.flightNumber),
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
      })
      ..startSync();

    ditto.presence.observe((graph) {
      if (kDebugMode) {
        print(graph.remotePeers.map((peer) => peer.deviceName).join(', '));
      }
    });

    sl.registerSingleton<Ditto>(ditto);
  }
}
