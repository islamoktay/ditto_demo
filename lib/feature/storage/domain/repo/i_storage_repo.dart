import 'dart:async';

import 'package:ditto_demo/feature/storage/domain/entity/meal.dart';

abstract class IStorageRepo {
  late final StreamController<List<Meal>> stream;
  Future<void> addMealItemToStorage(Meal meal);
  Future<void> listenMeals();
}
