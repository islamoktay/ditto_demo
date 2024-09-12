part of 'meal_cubit.dart';

@immutable
sealed class MealState {}

final class MealData extends MealState {
  MealData({
    required this.storageFrozenMeals,
    required this.storageOrderedMeals,
  });

  final Map<String, int> storageFrozenMeals;
  final Map<String, int> storageOrderedMeals;
}

final class MealLoading extends MealState {}

final class MealError extends MealState {
  MealError({required this.errorMessage});

  final String errorMessage;
}
