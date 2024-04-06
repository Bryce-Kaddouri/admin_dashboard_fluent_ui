import 'package:admin_dashboard/src/core/data/usecase/usecase.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/data/exception/failure.dart';
import '../../data/model/track_issue_model.dart';
import '../param/track_issue_update_status.dart';

abstract class TrackIssueRepository {
  Future<Either<DatabaseFailure, List<TrackIssueModel>>> getAllTrackIssues(
      NoParams params);
  Future<Either<DatabaseFailure, bool>> updateTrackIssue(
      TrackIssueUpdateStatusParam param);
}
