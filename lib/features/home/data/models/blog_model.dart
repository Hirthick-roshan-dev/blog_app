import 'package:blog_app/features/home/domain/entities/blog_entity.dart';

class BlogModel {
  final String id;
  final String posterId;
  final DateTime updatedAt;
  final String title;
  final String content;
  final String imageUrl;
  final String topic;

  BlogModel({
    required this.id,
    required this.title,
    required this.content,
    required this.imageUrl,
    required this.topic,
    required this.posterId,
    required this.updatedAt,
  });

  factory BlogModel.fromJson(Map<String, dynamic> json) {
    return BlogModel(
      id: json["id"],
      title: json["title"],
      content: json["content"],
      imageUrl: json["image_url"],
      topic: json["topic"],
      posterId: json["poster_id"],
      updatedAt: json["updated_at"] == null
          ? DateTime.now()
          : DateTime.parse(json["updated_at"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "content": content,
      "image_url": imageUrl,
      "topic": topic,
      "poster_id": posterId,
      "updated_at": updatedAt.toIso8601String(),
    };
  }

  BlogModel copyWith({
    String? id,
    String? posterId,
    DateTime? updatedAt,
    String? title,
    String? content,
    String? imageUrl,
    String? topic,
  }) {
    return BlogModel(
      id: id ?? this.id,
      posterId: posterId ?? this.posterId,
      updatedAt: updatedAt ?? this.updatedAt,
      title: title ?? this.title,
      content: content ?? this.content,
      imageUrl: imageUrl ?? this.imageUrl,
      topic: topic ?? this.topic,
    );
  }

  BlogEntity toEntity() {
    return BlogEntity(
      id: id,
      title: title,
      content: content,
      imageUrl: imageUrl,
      topic: topic,
      posterId: posterId,
      updatedAt: updatedAt,
    );
  }
}
