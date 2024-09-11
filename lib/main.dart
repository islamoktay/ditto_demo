import 'package:flutter/material.dart';

import 'package:permission_handler/permission_handler.dart';

import 'package:ditto_demo/core/di/di.dart' as di;
import 'package:ditto_demo/feature/home/presentation/view/home_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await [
    Permission.bluetoothConnect,
    Permission.bluetoothAdvertise,
    Permission.nearbyWifiDevices,
    Permission.bluetoothScan,
  ].request();

  await di.init();


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      home: const HomeView(),
    );
  }
}
