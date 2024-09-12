import 'package:ditto_demo/core/usecase/i_usecase.dart';
import 'package:ditto_demo/feature/db_meal/domain/repo/i_meal_db_repo.dart';

class ListenMealsUsecase implements Usecase<void, NoParams?> {
  const ListenMealsUsecase(this._mealRepo);
  final IMealDBRepo _mealRepo;

  @override
  Future<void> call([_]) async {
    await _mealRepo.listenMeals();
  }
}
