import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ditto_demo/core/di/di.dart';
import 'package:ditto_demo/feature/db_meal/presentation/cubit/meal_cubit.dart';

class StorageList extends StatelessWidget {
  const StorageList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: sl<MealCubit>(),
      child: BlocBuilder<MealCubit, MealState>(
        builder: (context, state) {
          switch (state) {
            case MealData():
              return Column(
                children: [
                  const Text('Frozen'),
                  _MealList(meals: state.storageFrozenMeals),
                  const Text('Ordered'),
                  _MealList(meals: state.storageOrderedMeals),
                ],
              );

            case MealLoading():
              return const Center(child: CircularProgressIndicator());
            case MealError():
              return Center(child: Text('Error\n${state.errorMessage}'));
          }
        },
      ),
    );
  }
}

class _MealList extends StatelessWidget {
  const _MealList({
    required this.meals,
  });
  final Map<String, int> meals;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemCount: meals.length,
        padding: const EdgeInsets.all(16),
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        itemBuilder: (context, index) => Text(
          '${meals.keys.toList()[index]} '
          '(${meals.values.map((e) => e.toString()).toList()[index]})',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
    );
  }
}
