import 'dart:convert';

class NotificationModel {
  final String id;
  final String userId;
  final String message;
  final bool isRead;
  final DateTime createdAt;
  final String type;

  NotificationModel({
    required this.id,
    required this.userId,
    required this.message,
    required this.isRead,
    required this.createdAt,
    required this.type,
  });

  NotificationModel copyWith({
    String? id,
    String? userId,
    String? message,
    bool? isRead,
    DateTime? createdAt,
    String? type,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      message: message ?? this.message,
      isRead: isRead ?? this.isRead,
      createdAt: createdAt ?? this.createdAt,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'user_id': userId,
      'message': message,
      'is_read': isRead,
      'created_at': createdAt.toIso8601String(),
      'type': type,
    };
  }

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      id: map['id'] as String,
      userId: map['user_id'] as String,
      message: map['message'] as String,
      isRead: map['is_read'] as bool,
      createdAt: DateTime.parse(map['created_at'] as String),
      type: map['type'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory NotificationModel.fromJson(String source) =>
      NotificationModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'NotificationModel(id: $id, userId: $userId, message: $message, isRead: $isRead, createdAt: $createdAt, type: $type)';
  }

  @override
  bool operator ==(covariant NotificationModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.userId == userId &&
        other.message == message &&
        other.isRead == isRead &&
        other.createdAt == createdAt &&
        other.type == type;
  }

  @override
  int get hashCode {
    return id.hashCode ^ userId.hashCode ^ message.hashCode ^ isRead.hashCode ^ createdAt.hashCode ^ type.hashCode;
  }
}
