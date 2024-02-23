import 'package:admin_dashboard/src/feature/category/business/param/category_add_param.dart';
import 'package:admin_dashboard/src/feature/category/business/repository/category_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/data/exception/failure.dart';
import '../../../../core/data/usecase/usecase.dart';
import '../../data/model/category_model.dart';

class CategoryGetCategoriesUseCase
    implements UseCase<List<CategoryModel>, NoParams> {
  final CategoryRepository categoryRepository;

  const CategoryGetCategoriesUseCase({
    required this.categoryRepository,
  });

  @override
  Future<Either<DatabaseFailure, List<CategoryModel>>> call(NoParams params) {
    return categoryRepository.getCategories(params);
  }
}
