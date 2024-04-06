import 'package:admin_dashboard/src/feature/track_issue/data/model/track_issue_model.dart';

class TrackIssueUpdateStatusParam {
  final int orderId;
  final DateTime orderDate;
  final TrackIssueStatus status;

  TrackIssueUpdateStatusParam({
    required this.orderId,
    required this.orderDate,
    required this.status,
  });
}
