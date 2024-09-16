import 'package:ditto_demo/feature/db_meal/domain/entity/meal.dart';

class MealItem {
  const MealItem({
    required this.name,
    required this.isFreezed,
    this.orderedTable,
    this.id,
  });

  factory MealItem.fromMap(Map<String, dynamic> map) {
    return MealItem(
      name: map['name'] as String,
      isFreezed: map['isFreezed'] as bool,
      id: map['_id'] as String,
      orderedTable:
          map['orderedTable'] != null ? map['orderedTable'] as String : null,
    );
  }

  factory MealItem.fromEntity(Meal meal) {
    return MealItem(
      name: meal.name,
      isFreezed: meal.isFreezed,
      orderedTable: meal.orderedTable,
      id: meal.id,
    );
  }

  final String name;
  final bool isFreezed;
  final String? orderedTable;
  final String? id;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'isFreezed': isFreezed,
      'orderedTable': orderedTable,
      if (id != null) '_id': id,
    };
  }

  Meal toEntity() {
    return Meal(
      id: id,
      isFreezed: isFreezed,
      orderedTable: orderedTable,
      name: name,
    );
  }
}
