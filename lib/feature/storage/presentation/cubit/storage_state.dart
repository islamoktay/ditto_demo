part of 'storage_cubit.dart';

@immutable
sealed class StorageState {}

final class StorageData extends StorageState {
  StorageData({required this.meals});

  final List<Meal> meals;
}

final class StorageLoading extends StorageState {}

final class StorageError extends StorageState {
  StorageError({required this.errorMessage});

  final String errorMessage;
}
