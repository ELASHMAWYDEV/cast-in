import 'dart:convert';

class FollowerModel {
  final String id;
  final String followingId;
  final String followerId;
  final DateTime createdAt;

  FollowerModel({
    required this.id,
    required this.followingId,
    required this.followerId,
    required this.createdAt,
  });

  FollowerModel copyWith({
    String? id,
    String? followingId,
    String? followerId,
    DateTime? createdAt,
  }) {
    return FollowerModel(
      id: id ?? this.id,
      followingId: followingId ?? this.followingId,
      followerId: followerId ?? this.followerId,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'following_id': followingId,
      'follower_id': followerId,
      'created_at': createdAt.toIso8601String(),
    };
  }

  factory FollowerModel.fromMap(Map<String, dynamic> map) {
    return FollowerModel(
      id: map['id'] as String,
      followingId: map['following_id'] as String,
      followerId: map['follower_id'] as String,
      createdAt: DateTime.parse(map['created_at'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory FollowerModel.fromJson(String source) => FollowerModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'FollowerModel(id: $id, followingId: $followingId, followerId: $followerId, createdAt: $createdAt)';
  }

  @override
  bool operator ==(covariant FollowerModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.followingId == followingId &&
        other.followerId == followerId &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^ followingId.hashCode ^ followerId.hashCode ^ createdAt.hashCode;
  }
}
