import 'package:ditto_demo/feature/flight_list/domain/entity/flight.dart';
import 'package:ditto_demo/feature/flight_list/presentation/cubit/flight_list_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FlightListCubit extends Cubit<FlightListState> {
  FlightListCubit() : super(FlightListInitialState());

  Future<void> fetchFlights() async {
    emit(
      FlightListSuccessState(
        flights: [
          Flight(flightNumber: 1905),
          Flight(flightNumber: 1967),
          Flight(flightNumber: 1903),
          Flight(flightNumber: 1907),
          Flight(flightNumber: 1961),
          Flight(flightNumber: 3406),
        ],
      ),
    );
  }
}
