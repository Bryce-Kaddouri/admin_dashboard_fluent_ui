import 'package:dartz/dartz.dart';

import '../../../../core/data/exception/failure.dart';
import '../../../../core/data/usecase/usecase.dart';
import '../../data/model/track_issue_model.dart';
import '../repository/track_issue_repository.dart';

class TrackIssueGetAllTrackIssuesUsecase extends UseCase<List<TrackIssueModel>, NoParams> {
  final TrackIssueRepository repository;

  TrackIssueGetAllTrackIssuesUsecase({required this.repository});

  @override
  Future<Either<DatabaseFailure, List<TrackIssueModel>>> call(NoParams params) async {
    return repository.getAllTrackIssues(params);
  }
}
