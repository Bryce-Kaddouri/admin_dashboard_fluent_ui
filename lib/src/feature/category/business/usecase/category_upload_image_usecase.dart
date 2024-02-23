import 'package:admin_dashboard/src/feature/category/business/param/category_add_param.dart';
import 'package:admin_dashboard/src/feature/category/business/repository/category_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/data/exception/failure.dart';
import '../../../../core/data/usecase/usecase.dart';
import '../../data/model/category_model.dart';

class CategoryUploadImageUseCase implements UseCase<String, Uint8List> {
  final CategoryRepository categoryRepository;

  const CategoryUploadImageUseCase({
    required this.categoryRepository,
  });

  @override
  Future<Either<StorageFailure, String>> call(Uint8List bytes) {
    return categoryRepository.uploadImage(bytes);
  }
}
