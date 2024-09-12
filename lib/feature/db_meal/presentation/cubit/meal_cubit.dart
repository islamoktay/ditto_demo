import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ditto_demo/feature/db_meal/domain/usecase/add_meal_to_storage_usecase.dart';
import 'package:ditto_demo/feature/db_meal/domain/usecase/get_meal_lists.dart';
import 'package:ditto_demo/feature/db_meal/domain/usecase/get_meal_stream_usecase.dart';
import 'package:ditto_demo/feature/db_meal/domain/usecase/listen_meals_usecase.dart';

part 'meal_state.dart';

class MealCubit extends Cubit<MealState> {
  MealCubit(
    this._addMealToStorageUsecase,
    this._listenMealsUsecase,
    this._getStreamUsecase,
    this._getMealListsUsecase,
  ) : super(MealLoading());

  final AddMealToStorageUsecase _addMealToStorageUsecase;
  final ListenMealsUsecase _listenMealsUsecase;
  final GetMealStreamUsecase _getStreamUsecase;
  final GetMealListsUsecase _getMealListsUsecase;

  Future<void> addMealToStorageUsecase(String mealName) async {
    MealState? prevState;
    if (state.runtimeType == MealData) prevState = state;

    try {
      emit(MealLoading());
      await _addMealToStorageUsecase.call(mealName);
    } catch (e) {
      emit(MealError(errorMessage: e.toString()));
    } finally {
      if (prevState != null) emit(prevState);
    }
  }

  Future<void> listenStorageMeals() async {
    await _listenMealsUsecase();

    _getStreamUsecase().listen(
      (event) {
        if (!isClosed) {
          final result = _getMealListsUsecase(event);
          emit(
            MealData(
              storageFrozenMeals: result.$1,
              storageOrderedMeals: result.$2,
            ),
          );
        }
      },
    );
  }
}
