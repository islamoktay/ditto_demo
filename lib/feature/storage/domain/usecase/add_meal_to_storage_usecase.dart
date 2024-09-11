import 'package:ditto_demo/core/usecase/i_usecase.dart';
import 'package:ditto_demo/feature/storage/domain/entity/meal.dart';
import 'package:ditto_demo/feature/storage/domain/repo/i_storage_repo.dart';

class AddMealToStorageUsecase implements Usecase<void, String> {
  const AddMealToStorageUsecase(this._storageRepo);
  final IStorageRepo _storageRepo;

  @override
  Future<void> call(String param) async {
    final meal = Meal(
      isFreezed: true,
      orderedTable: null,
      name: param,
    );
    
    await _storageRepo.addMealItemToStorage(meal);
  }
}
