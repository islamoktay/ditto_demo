import 'package:ditto_demo/feature/storage/domain/entity/meal.dart';

class MealItem {
  const MealItem({
    required this.name,
    required this.isFreezed,
    this.orderedTable,
  });

  factory MealItem.fromMap(Map<String, dynamic> map) {
    return MealItem(
      name: map['name'] as String,
      isFreezed: map['isFreezed'] as bool,
      orderedTable:
          map['orderedTable'] != null ? map['orderedTable'] as String : null,
    );
  }

  factory MealItem.fromEntity(Meal meal) {
    return MealItem(
      name: meal.name,
      isFreezed: meal.isFreezed,
      orderedTable: meal.orderedTable,
    );
  }

  final String name;
  final bool isFreezed;
  final String? orderedTable;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'isFreezed': isFreezed,
      'orderedTable': orderedTable,
    };
  }

  Meal toEntity() {
    return Meal(
      isFreezed: isFreezed,
      orderedTable: orderedTable,
      name: name,
    );
  }
}
