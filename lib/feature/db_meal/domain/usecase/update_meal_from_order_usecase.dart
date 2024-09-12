import 'package:ditto_demo/core/usecase/i_usecase.dart';
import 'package:ditto_demo/feature/db_meal/domain/entity/update_meal_request.dart';
import 'package:ditto_demo/feature/db_meal/domain/repo/i_meal_db_repo.dart';

class UpdateMealFromOrderUsecase implements Usecase<void, UpdateMealRequest> {
  const UpdateMealFromOrderUsecase(this._mealRepo);
  final IMealDBRepo _mealRepo;

  @override
  Future<void> call(UpdateMealRequest param) async {
    return _mealRepo.updateMealFromOrder(param);
  }
}
