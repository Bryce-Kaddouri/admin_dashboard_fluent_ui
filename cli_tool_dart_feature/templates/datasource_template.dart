import 'package:dartz/dartz.dart';

import '../../../../../core/data/exception/failure.dart';
import '../model/feature_name_model.dart';

class FeatureNameDataSource {
  // final FeatureNameLocalDataSource localDataSource;
  // final FeatureNameRemoteDataSource remoteDataSource;

  // FeatureNameDataSource({required this.localDataSource, required this.remoteDataSource});

  Future<Either<DatabaseFailure, List<FeatureNameModel>>> getAllFeatureName() async {
    try {
      // final localData = await localDataSource.getAllFeatureName();
      return Right([]);
    } catch (e) {
      return Left(DatabaseFailure(errorMessage: e.toString()));
    }
  }
}
