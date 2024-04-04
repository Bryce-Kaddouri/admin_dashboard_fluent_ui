import 'package:admin_dashboard/src/core/data/usecase/usecase.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/data/exception/failure.dart';
import '../../data/model/track_issue_model.dart';

abstract class TrackIssueRepository {
  Future<Either<DatabaseFailure, List<TrackIssueModel>>> getAllTrackIssues(NoParams params);
}
