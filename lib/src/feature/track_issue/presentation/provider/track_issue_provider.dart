import 'package:flutter/material.dart';

import '../../../../core/data/usecase/usecase.dart';
import '../../business/usecase/track_issue_get_all_track_issues_usecase.dart';
import '../../data/model/track_issue_model.dart';

class TrackIssueProvider with ChangeNotifier {
  final TrackIssueGetAllTrackIssuesUsecase getAllTrackIssuesUsecase;
  TrackIssueProvider({
    required this.getAllTrackIssuesUsecase,
  });

  Future<List<TrackIssueModel>?> getAllTrackIssues() async {
    NoParams params = NoParams();
    List<TrackIssueModel>? trackIssues;
    final result = await getAllTrackIssuesUsecase.call(params);
    result.fold((l) {
      print('error from provider');
      print(l.errorMessage);
    }, (r) {
      trackIssues = r;
    });

    print('response from provider');
    print(trackIssues?.length);

    return trackIssues;
  }
}
