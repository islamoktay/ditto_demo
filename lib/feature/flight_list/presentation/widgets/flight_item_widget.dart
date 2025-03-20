import 'package:ditto_demo/feature/flight_list/domain/entity/flight.dart';
import 'package:flutter/material.dart';

class FlightItemWidget extends StatelessWidget {
  const FlightItemWidget({
    required this.onTab,
    required this.flight,
    super.key,
  });

  final VoidCallback onTab;
  final Flight flight;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 1,
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      child: Container(
        decoration: const BoxDecoration(),
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: InkWell(
            onTap: onTab,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'TK ${flight.flightNumber}',
                ),
                const Icon(Icons.chevron_right),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
