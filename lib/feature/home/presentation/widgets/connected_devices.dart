import 'package:ditto_demo/core/di/di.dart';
import 'package:ditto_demo/feature/home/presentation/cubit/connected_devices_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConnectedDevices extends StatelessWidget {
  const ConnectedDevices({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: sl<ConnectedDevicesCubit>(),
      child: BlocBuilder<ConnectedDevicesCubit, List<String>>(
        builder: (context, list) {
          return Row(
            children: [
              const Text('Connected Devices:'),
              ...list.map((device) => Text('* $device'))
            ],
          );
        },
      ),
    );
  }
}
