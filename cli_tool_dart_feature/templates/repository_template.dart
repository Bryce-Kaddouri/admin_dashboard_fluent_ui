import 'package:dartz/dartz.dart';

import '../../../../../core/data/exception/failure.dart';
import '../../data/model/feature_name_model.dart';

abstract class FeatureNameRepository {
  Future<Either<DatabaseFailure, List<FeatureNameModel>>> getAllFeatureName();
}
