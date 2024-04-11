import 'package:admin_dashboard/src/feature/ingredient/business/repository/ingredient_repository.dart';
import 'package:admin_dashboard/src/feature/ingredient/data/model/ingredient_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/data/exception/failure.dart';
import '../../../../core/data/usecase/usecase.dart';

class IngredientAddUseCase implements UseCase<IngredientModel, IngredientModel> {
  final IngredientRepository ingredientRepository;

  const IngredientAddUseCase({
    required this.ingredientRepository,
  });

  @override
  Future<Either<DatabaseFailure, IngredientModel>> call(IngredientModel param) {
    return ingredientRepository.addIngredient(param);
  }
}
