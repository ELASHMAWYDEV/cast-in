import 'dart:convert';

import 'package:cast_in/utils/app_enums.dart';

class PostModel {
  final String id;
  final String name;
  final String username;
  final String content;
  final List<String>? imageUrl;
  final String avatarUrl;
  final int likes;
  final int comments;
  final PostContentType contentType;

  PostModel({
    required this.id,
    required this.name,
    required this.username,
    required this.content,
    this.imageUrl,
    required this.avatarUrl,
    required this.likes,
    required this.comments,
    required this.contentType,
  });

  PostModel copyWith({
    String? id,
    String? name,
    String? username,
    String? content,
    List<String>? imageUrl,
    String? avatarUrl,
    int? likes,
    int? comments,
    PostContentType? contentType,
  }) {
    return PostModel(
      id: id ?? this.id,
      name: name ?? this.name,
      username: username ?? this.username,
      content: content ?? this.content,
      imageUrl: imageUrl ?? this.imageUrl,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      likes: likes ?? this.likes,
      comments: comments ?? this.comments,
      contentType: contentType ?? this.contentType,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'username': username,
      'content': content,
      'image_url': imageUrl,
      'avatar_url': avatarUrl,
      'likes': likes,
      'comments': comments,
      'content_type': contentType.toString(),
    };
  }

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      id: map['id'] as String,
      name: map['name'] as String,
      username: map['username'] as String,
      content: map['content'] as String,
      imageUrl: map['image_url'] != null ? List<String>.from(map['image_url']) : null,
      avatarUrl: map['avatar_url'] as String,
      likes: map['likes'] as int,
      comments: map['comments'] as int,
      contentType: PostContentType.values.firstWhere((e) => e.toString() == map['content_type']),
    );
  }

  String toJson() => json.encode(toMap());

  factory PostModel.fromJson(String source) => PostModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PostModel(id: $id, name: $name, username: $username, content: $content, imageUrl: $imageUrl, avatarUrl: $avatarUrl, likes: $likes, comments: $comments, contentType: $contentType)';
  }

  @override
  bool operator ==(covariant PostModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.username == username &&
        other.content == content &&
        other.imageUrl == imageUrl &&
        other.avatarUrl == avatarUrl &&
        other.likes == likes &&
        other.comments == comments &&
        other.contentType == contentType;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        username.hashCode ^
        content.hashCode ^
        imageUrl.hashCode ^
        avatarUrl.hashCode ^
        likes.hashCode ^
        comments.hashCode ^
        contentType.hashCode;
  }
}
