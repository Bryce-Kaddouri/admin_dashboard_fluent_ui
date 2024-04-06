enum TrackIssueType {
  notCollected,
}

enum TrackIssueStatus {
  unresolved,
  inProgress,
  resolved,
  ignored,
}

class TrackIssueModel {
  final int orderId;
  final DateTime orderDate;
  final TrackIssueType issueType;
  final DateTime reportedAt;
  final TrackIssueStatus resolutionStatus;
  final DateTime? resolvedAt;

  TrackIssueModel({
    required this.orderId,
    required this.orderDate,
    required this.issueType,
    required this.reportedAt,
    required this.resolutionStatus,
    this.resolvedAt,
  });

  factory TrackIssueModel.fromJson(Map<String, dynamic> json) {
    return TrackIssueModel(
      orderId: json['order_id'],
      orderDate: DateTime.parse(json['order_date']),
      issueType: json['issue_type'] == 'Order Not Collected'
          ? TrackIssueType.notCollected
          : throw Exception('Invalid issue type'),
      reportedAt: DateTime.parse(json['reported_at']),
      resolutionStatus: json['resolution_status'] == 'Unresolved'
          ? TrackIssueStatus.unresolved
          : json['resolution_status'] == 'In progress'
              ? TrackIssueStatus.inProgress
              : json['resolution_status'] == 'Resolved'
                  ? TrackIssueStatus.resolved
                  : json['resolution_status'] == 'Ignored'
                      ? TrackIssueStatus.ignored
                      : throw Exception('Invalid resolution status'),
      resolvedAt: json['resolved_at'] != null
          ? DateTime.parse(json['resolved_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'order_id': orderId,
        'order_date': orderDate.toIso8601String(),
        'issue_type': issueType,
        'reported_at': reportedAt.toIso8601String(),
        'resolution_status': resolutionStatus,
        'resolved_at': resolvedAt?.toIso8601String(),
      };

  List<String> get props => [
        'order_id',
        'order_date',
        'issue_type',
        'reported_at',
        'resolution_status',
        'resolved_at',
      ];

  static String getStatusString(TrackIssueStatus status) {
    switch (status) {
      case TrackIssueStatus.unresolved:
        return 'Unresolved';
      case TrackIssueStatus.inProgress:
        return 'In progress';
      case TrackIssueStatus.resolved:
        return 'Resolved';
      case TrackIssueStatus.ignored:
        return 'Ignored';
    }
  }

  static String getTypeString(TrackIssueType type) {
    switch (type) {
      case TrackIssueType.notCollected:
        return 'Order Not Collected';
    }
  }

  static TrackIssueStatus getStatusFromString(value) {
    switch (value) {
      case 'Unresolved':
        return TrackIssueStatus.unresolved;
      case 'In progress':
        return TrackIssueStatus.inProgress;
      case 'Resolved':
        return TrackIssueStatus.resolved;
      case 'Ignored':
        return TrackIssueStatus.ignored;
      default:
        throw Exception('Invalid resolution status');
    }
  }
}
