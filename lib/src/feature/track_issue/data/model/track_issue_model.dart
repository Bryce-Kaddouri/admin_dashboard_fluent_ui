class TrackIssueModel {
  final int orderId;
  final DateTime orderDate;
  final String issueType;
  final DateTime reportedAt;
  final String resolutionStatus;
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
      issueType: json['issue_type'],
      reportedAt: DateTime.parse(json['reported_at']),
      resolutionStatus: json['resolution_status'],
      resolvedAt: json['resolved_at'] != null ? DateTime.parse(json['resolved_at']) : null,
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
}
