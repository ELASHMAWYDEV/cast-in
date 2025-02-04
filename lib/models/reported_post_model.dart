import 'dart:convert';

class ReportedPost {
  final String postId;
  final String reporterId;
  final String reporterName;
  final String postOwnerId;
  final String postOwnerName;
  final String reason;
  final DateTime reportedAt;

  ReportedPost({
    required this.postId,
    required this.reporterId,
    required this.reporterName,
    required this.postOwnerId,
    required this.postOwnerName,
    required this.reason,
    required this.reportedAt,
  });

  ReportedPost copyWith({
    String? postId,
    String? reporterId,
    String? reporterName,
    String? postOwnerId,
    String? postOwnerName,
    String? reason,
    DateTime? reportedAt,
  }) {
    return ReportedPost(
      postId: postId ?? this.postId,
      reporterId: reporterId ?? this.reporterId,
      reporterName: reporterName ?? this.reporterName,
      postOwnerId: postOwnerId ?? this.postOwnerId,
      postOwnerName: postOwnerName ?? this.postOwnerName,
      reason: reason ?? this.reason,
      reportedAt: reportedAt ?? this.reportedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'post_id': postId,
      'reporter_id': reporterId,
      'reporter_name': reporterName,
      'post_owner_id': postOwnerId,
      'post_owner_name': postOwnerName,
      'reason': reason,
      'reported_at': reportedAt.toIso8601String(),
    };
  }

  factory ReportedPost.fromMap(Map<String, dynamic> map) {
    return ReportedPost(
      postId: map['post_id'] as String,
      reporterId: map['reporter_id'] as String,
      reporterName: map['reporter_name'] as String,
      postOwnerId: map['post_owner_id'] as String,
      postOwnerName: map['post_owner_name'] as String,
      reason: map['reason'] as String,
      reportedAt: DateTime.parse(map['reported_at'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory ReportedPost.fromJson(String source) => ReportedPost.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ReportedPost(postId: $postId, reporterId: $reporterId, reporterName: $reporterName, postOwnerId: $postOwnerId, postOwnerName: $postOwnerName, reason: $reason, reportedAt: $reportedAt)';
  }

  @override
  bool operator ==(covariant ReportedPost other) {
    if (identical(this, other)) return true;

    return other.postId == postId &&
        other.reporterId == reporterId &&
        other.reporterName == reporterName &&
        other.postOwnerId == postOwnerId &&
        other.postOwnerName == postOwnerName &&
        other.reason == reason &&
        other.reportedAt == reportedAt;
  }

  @override
  int get hashCode {
    return postId.hashCode ^
        reporterId.hashCode ^
        reporterName.hashCode ^
        postOwnerId.hashCode ^
        postOwnerName.hashCode ^
        reason.hashCode ^
        reportedAt.hashCode;
  }
}
