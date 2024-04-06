import 'package:flutter/material.dart';

import '../../../../core/data/usecase/usecase.dart';
import '../../business/param/track_issue_update_status.dart';
import '../../business/usecase/track_issue_get_all_track_issues_usecase.dart';
import '../../business/usecase/track_issue_update_track_issue_usecase.dart';
import '../../data/model/track_issue_model.dart';

class TrackIssueProvider with ChangeNotifier {
  final TrackIssueGetAllTrackIssuesUsecase getAllTrackIssuesUsecase;
  final TrackIssueUpdateTrackIssueUsecase updateTrackIssueUsecase;
  TrackIssueProvider({
    required this.getAllTrackIssuesUsecase,
    required this.updateTrackIssueUsecase,
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

  Future<bool> updateTrackIssue(
      int orderId, DateTime orderDate, TrackIssueStatus status) async {
    TrackIssueUpdateStatusParam param = TrackIssueUpdateStatusParam(
      orderId: orderId,
      orderDate: orderDate,
      status: status,
    );
    bool isUpdated = false;
    final result = await updateTrackIssueUsecase.call(param);
    result.fold((l) {
      print('error from provider');
      print(l.errorMessage);
    }, (r) {
      isUpdated = r;
    });

    print('response from provider');
    print(isUpdated);

    return isUpdated;
  }
}
