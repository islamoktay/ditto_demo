import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:ditto_demo/core/di/di.dart';
import 'package:ditto_demo/feature/db_meal/presentation/cubit/meal_cubit.dart';
import 'package:ditto_demo/feature/db_seats/domain/entity/seat.dart';
import 'package:ditto_demo/feature/db_seats/presentation/cubit/seat_cubit.dart';

class ChooseMealDialog extends HookWidget {
  const ChooseMealDialog({
    required this.seatNumber,
    super.key,
  });
  final int seatNumber;
  @override
  Widget build(BuildContext context) {
    final chosenMenu = useState('');
    return BlocProvider.value(
      value: sl<MealCubit>(),
      child: BlocBuilder<MealCubit, MealState>(
        builder: (context, state) {
          switch (state) {
            case MealData():
              return Dialog(
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ...state.storageFrozenMeals.keys.map(
                        (e) => GestureDetector(
                          onTap: () => chosenMenu.value = e,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Text(
                              e,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: chosenMenu.value == e
                                        ? Colors.green
                                        : Colors.black,
                                  ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            context.read<SeatCubit>().takeOrder(
                                  Seat(
                                    meal: chosenMenu.value,
                                    seatNumber: seatNumber,
                                    id: null,
                                  ),
                                );
                            Navigator.of(context).pop();
                          },
                          child: const Text('Take Order'),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            case MealLoading():
            case MealError():
              return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
