import 'package:ditto_demo/feature/flight_list/domain/entity/flight.dart';

sealed class FlightListState {}

class FlightListInitialState extends FlightListState {}

class FlightListSuccessState extends FlightListState {
  FlightListSuccessState({required this.flights});

  final List<Flight> flights;
}
