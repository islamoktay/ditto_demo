import 'dart:async';

import 'package:ditto_live/ditto_live.dart';

import 'package:ditto_demo/core/di/di.dart';
import 'package:ditto_demo/feature/storage/data/model/meal_item.dart';
import 'package:ditto_demo/feature/storage/domain/entity/meal.dart';
import 'package:ditto_demo/feature/storage/domain/repo/i_storage_repo.dart';

class StorageRepo implements IStorageRepo {
  @override
  Future<void> addMealItemToStorage(Meal meal) async {
    await sl<Ditto>().store.execute(
      'INSERT INTO meals DOCUMENTS (:meal)',
      arguments: {'meal': MealItem.fromEntity(meal).toMap()},
    );
  }

  @override
  late StreamController<List<Meal>> stream;

  @override
  Future<void> listenMeals() async {
    stream = StreamController<List<Meal>>.broadcast(sync: true);

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
}
