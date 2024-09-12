import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ditto_demo/core/di/di.dart';
import 'package:ditto_demo/feature/db_seats/domain/entity/seat.dart';
import 'package:ditto_demo/feature/db_seats/presentation/cubit/seat_cubit.dart';
import 'package:ditto_demo/feature/seats/presentation/widgets/choose_meal_dialog.dart';

class SeatsView extends StatelessWidget {
  const SeatsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Seats')),
      body: BlocProvider.value(
        value: sl<SeatCubit>(),
        child: BlocBuilder<SeatCubit, List<Seat>>(
          builder: (context, state) {
            return GridView.builder(
              itemCount: 15,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
              ),
              padding: const EdgeInsets.all(16),
              itemBuilder: (context, index) {
                String? mealName;

                for (final element in state) {
                  if (element.seatNumber == (index + 1)) {
                    mealName = element.meal;
                    break;
                  }
                }

                return GestureDetector(
                  onTap: () => showDialog<void>(
                    context: context,
                    builder: (context) =>
                        ChooseMealDialog(seatNumber: index + 1),
                  ),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        Text((index + 1).toString()),
                        if (mealName != null)
                          Text(
                            mealName,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  color: Colors.green,
                                ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
