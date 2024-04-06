import 'package:dartz/dartz.dart';

import '../../../../core/data/exception/failure.dart';
import '../../../../core/data/usecase/usecase.dart';
import '../param/track_issue_update_status.dart';
import '../repository/track_issue_repository.dart';

class TrackIssueUpdateTrackIssueUsecase
    extends UseCase<bool, TrackIssueUpdateStatusParam> {
  final TrackIssueRepository repository;

  TrackIssueUpdateTrackIssueUsecase({required this.repository});

  @override
  Future<Either<DatabaseFailure, bool>> call(
      TrackIssueUpdateStatusParam params) async {
    return repository.updateTrackIssue(params);
  }
}
