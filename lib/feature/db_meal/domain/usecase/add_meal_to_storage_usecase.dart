import 'package:ditto_demo/core/usecase/i_usecase.dart';
import 'package:ditto_demo/feature/db_meal/domain/entity/meal.dart';
import 'package:ditto_demo/feature/db_meal/domain/repo/i_meal_db_repo.dart';


class AddMealToStorageUsecase implements Usecase<void, String> {
  const AddMealToStorageUsecase(this._mealRepo);
  final IMealDBRepo _mealRepo;

  @override
  Future<void> call(String param) async {
    final meal = Meal(
      id: null,
      isFreezed: true,
      orderedTable: null,
      name: param,
    );
    
    await _mealRepo.addMealItemToStorage(meal);
  }
}
