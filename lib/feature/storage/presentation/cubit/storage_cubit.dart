import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ditto_demo/feature/storage/domain/repo/i_storage_repo.dart';
import 'package:ditto_demo/feature/storage/domain/usecase/add_meal_to_storage_usecase.dart';

part 'storage_state.dart';

class StorageCubit extends Cubit<StorageState> {
  StorageCubit(
    this._addMealToStorageUsecase,
    this._storageRepo,
  ) : super(StorageLoading());

  final AddMealToStorageUsecase _addMealToStorageUsecase;
  final IStorageRepo _storageRepo;

  Future<void> addMealToStorageUsecase(String mealName) async {
    StorageState? prevState;
    if (state.runtimeType == StorageData) prevState = state;

    try {
      emit(StorageLoading());
      await _addMealToStorageUsecase.call(mealName);
    } catch (e) {
      emit(StorageError(errorMessage: e.toString()));
    } finally {
      if (prevState != null) emit(prevState);
    }
  }

  Future<void> listenStorageMeals() async {
    await _storageRepo.listenMeals();
    _storageRepo.stream.stream.listen(
      (event) {
        final map = <String, int>{};
        for (var i = 0; i < event.length; i++) {
          final hasElement = map.keys.contains(event[i].name);
          if (hasElement) {
            final count = (map[event[i].name] ?? 0) + 1;
            map[event[i].name] = count;
          } else {
            map.putIfAbsent(event[i].name, () => 1);
          }
        }

        if (!isClosed) emit(StorageData(meals: map));
      },
    );
  }
}
