import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ditto_demo/feature/storage/domain/entity/meal.dart';
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
        if (!isClosed) emit(StorageData(meals: event));
      },
    );
  }
}
