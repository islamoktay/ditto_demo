import 'package:ditto_demo/core/di/di.dart';
import 'package:ditto_demo/core/services/navigation_service/navigation_service.dart';
import 'package:ditto_demo/feature/flight_list/presentation/cubit/flight_list_cubit.dart';
import 'package:ditto_demo/feature/flight_list/presentation/cubit/flight_list_state.dart';
import 'package:ditto_demo/feature/flight_list/presentation/widgets/flight_item_widget.dart';
import 'package:ditto_demo/feature/home/presentation/view/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FlightListView extends StatefulWidget {
  const FlightListView({super.key});

  @override
  State<FlightListView> createState() => _FlightListViewStateState();
}

class _FlightListViewStateState extends State<FlightListView> {
  late TextEditingController controller;

  @override
  void initState() {
    controller = TextEditingController();
    sl<FlightListCubit>().fetchFlights();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flight List')),
      body: BlocProvider.value(
        value: sl<FlightListCubit>(),
        child: BlocBuilder<FlightListCubit, FlightListState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(32),
              child: switch (state) {
                FlightListInitialState() => Container(),
                FlightListSuccessState() => buildFlightList(state),
              },
            );
          },
        ),
      ),
    );
  }

  Widget buildFlightList(FlightListSuccessState state) {
    return Column(
      children: state.flights.map((flight) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: FlightItemWidget(
            flight: flight,
            onTab: () {
              sl<NavigationService>().push(
                context: context,
                target: HomeView(
                  flight: flight,
                ),
              );
            },
          ),
        );
      }).toList(),
    );
  }
}
