import 'package:flutter_bloc/flutter_bloc.dart';

class ConnectedDevicesCubit extends Cubit<List<String>> {
  ConnectedDevicesCubit() : super([]);

  Future<void> broadcast(List<String> deviceList) async {
    emit(deviceList);
  }
}
