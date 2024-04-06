import 'package:admin_dashboard/src/core/data/usecase/usecase.dart';
import 'package:admin_dashboard/src/feature/track_issue/business/param/track_issue_update_status.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/data/exception/failure.dart';
import '../../business/repository/track_issue_repository.dart';
import '../datasource/track_issue_datasource.dart';
import '../model/track_issue_model.dart';

class TrackIssueRepositoryImpl implements TrackIssueRepository {
  final TrackIssueDataSource dataSource;

  TrackIssueRepositoryImpl({required this.dataSource});

  @override
  Future<Either<DatabaseFailure, List<TrackIssueModel>>> getAllTrackIssues(
      NoParams params) async {
    return dataSource.getAllTrackIssues(params);
  }

  @override
  Future<Either<DatabaseFailure, bool>> updateTrackIssue(
      TrackIssueUpdateStatusParam param) async {
    return dataSource.updateTrackIssue(param);
  }
}
