import 'package:ditto_demo/core/usecase/i_usecase.dart';
import 'package:ditto_demo/feature/db_meal/domain/entity/meal.dart';
import 'package:ditto_demo/feature/db_meal/domain/repo/i_meal_db_repo.dart';

class GetMealStreamUsecase implements Usecase<Stream<List<Meal>>, NoParams?> {
  const GetMealStreamUsecase(this._mealRepo);
  final IMealDBRepo _mealRepo;

  @override
  Stream<List<Meal>> call([_]) {
    return _mealRepo.stream.stream;
  }
}
