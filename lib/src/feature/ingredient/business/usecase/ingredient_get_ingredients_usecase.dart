import 'package:admin_dashboard/src/feature/ingredient/business/repository/ingredient_repository.dart';
import 'package:admin_dashboard/src/feature/ingredient/data/model/ingredient_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/data/exception/failure.dart';
import '../../../../core/data/usecase/usecase.dart';

class IngredientGetIngredientsUseCase implements UseCase<List<IngredientModel>, NoParams> {
  final IngredientRepository ingredientRepository;

  const IngredientGetIngredientsUseCase({
    required this.ingredientRepository,
  });

  @override
  Future<Either<DatabaseFailure, List<IngredientModel>>> call(NoParams params) {
    return ingredientRepository.getIngredients(params);
  }
}
