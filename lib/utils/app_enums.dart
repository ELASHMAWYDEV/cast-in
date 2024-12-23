// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

enum PostContentType {
  text,
  image,
}

class PostModel {
  final String name;
  final String username;
  final String content;
  final String? imageUrl;
  final String avatarUrl;
  final int likes;
  final int comments;
  final PostContentType contentType;

  PostModel({
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
    String? name,
    String? username,
    String? content,
    String? imageUrl,
    String? avatarUrl,
    int? likes,
    int? comments,
    PostContentType? contentType,
  }) {
    return PostModel(
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
      'name': name,
      'username': username,
      'content': content,
      'imageUrl': imageUrl,
      'avatarUrl': avatarUrl,
      'likes': likes,
      'comments': comments,
      'contentType': contentType.toString(),
    };
  }

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      name: map['name'] as String,
      username: map['username'] as String,
      content: map['content'] as String,
      imageUrl: map['imageUrl'] != null ? map['imageUrl'] as String : null,
      avatarUrl: map['avatarUrl'] as String,
      likes: map['likes'] as int,
      comments: map['comments'] as int,
      contentType: map['contentType'] as PostContentType,
    );
  }

  String toJson() => json.encode(toMap());

  factory PostModel.fromJson(String source) => PostModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
