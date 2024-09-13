import 'dart:async';
import 'dart:developer';

import 'package:ditto_live/ditto_live.dart';

import 'package:ditto_demo/core/di/di.dart';
import 'package:ditto_demo/feature/db_meal/data/model/meal_item.dart';
import 'package:ditto_demo/feature/db_meal/domain/entity/meal.dart';
import 'package:ditto_demo/feature/db_meal/domain/entity/update_meal_request.dart';
import 'package:ditto_demo/feature/db_meal/domain/repo/i_meal_db_repo.dart';

class MealDbRepo implements IMealDBRepo {
  MealDbRepo() {
    stream = StreamController<List<Meal>>.broadcast();
  }
  @override
  late final StreamController<List<Meal>> stream;

  @override
  Future<void> addMealItemToStorage(Meal meal) async {
    try {
      await sl<Ditto>().store.execute(
        'INSERT INTO meals DOCUMENTS (:meal)',
        arguments: {'meal': MealItem.fromEntity(meal).toMap()},
      );
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Future<void> listenMeals() async {
    await sl<Ditto>().sync.registerSubscription('SELECT * FROM meals');
    final result = await sl<Ditto>().store.execute('SELECT * FROM meals');

    final meals =
        result.items.map((e) => MealItem.fromMap(e.value).toEntity()).toList();

    stream.add(meals);

    await sl<Ditto>().store.registerObserver(
      'SELECT * FROM meals',
      onChange: (val) {
        final list =
            val.items.map((e) => MealItem.fromMap(e.value).toEntity()).toList();
        stream.add(list);
      },
    );
  }

  @override
  Future<void> updateMealFromOrder(UpdateMealRequest updateMealReq) async {
    final result = await sl<Ditto>().store.execute('SELECT * FROM meals');

    final meals =
        result.items.map((e) => MealItem.fromMap(e.value).toEntity()).toList();
    Meal? meal;

    for (final element in meals) {
      if (element.name == updateMealReq.mealName && element.isFreezed) {
        meal = element;
        break;
      }
    }

    if (meal != null) {
      await sl<Ditto>().store.execute("""
          UPDATE meals SET isFreezed = false, orderedTable = '${updateMealReq.seatNumber}' WHERE _id = '${meal.id}'
          """);
    }
  }

  @override
  Future<void> clearDB() async {
    await sl<Ditto>().store.execute('EVICT FROM meals WHERE isFreezed = true');
    await sl<Ditto>().store.execute('EVICT FROM meals WHERE isFreezed = false');
  }
}
