import 'package:dartz/dartz.dart';

import '../../../../../core/data/exception/failure.dart';
import '../../business/repository/feature_name_repository.dart';
import '../datasource/feature_name_datasource.dart';
import '../model/feature_name_model.dart';

class FeatureNameRepositoryImpl implements FeatureNameRepository {
  final FeatureNameDataSource dataSource;

  FeatureNameRepositoryImpl({required this.dataSource});

  @override
  Future<Either<DatabaseFailure, List<FeatureNameModel>>> getAllFeatureName() async {
    return dataSource.getAllFeatureName();
  }
}
