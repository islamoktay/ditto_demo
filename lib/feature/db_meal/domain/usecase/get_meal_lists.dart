import 'package:ditto_demo/core/usecase/i_usecase.dart';
import 'package:ditto_demo/feature/db_meal/domain/entity/meal.dart';

class GetMealListsUsecase
    implements Usecase<(Map<String, int>, Map<String, int>), List<Meal>> {
  const GetMealListsUsecase();

  @override
  (Map<String, int>, Map<String, int>) call(List<Meal> param) {
    final frozenList = <Meal>[];
    final orderedList = <Meal>[];

    for (final element in param) {
      if (element.isFreezed) {
        frozenList.add(element);
      } else {
        orderedList.add(element);
      }
    }

    final frozenMap = _convertIntoMap(frozenList);
    final orderedMap = _convertIntoMap(orderedList);

    return (frozenMap, orderedMap);
  }
}

Map<String, int> _convertIntoMap(List<Meal> event) {
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
  return map;
}
