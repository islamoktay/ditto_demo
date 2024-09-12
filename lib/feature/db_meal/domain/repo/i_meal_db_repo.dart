import 'dart:async';

import 'package:ditto_demo/feature/db_meal/domain/entity/meal.dart';
import 'package:ditto_demo/feature/db_meal/domain/entity/update_meal_request.dart';

abstract class IMealDBRepo {
  late final StreamController<List<Meal>> stream;
  Future<void> addMealItemToStorage(Meal meal);
  Future<void> listenMeals();
  Future<void> updateMealFromOrder(UpdateMealRequest updateMealReq);
  Future<void> clearDB();
}
