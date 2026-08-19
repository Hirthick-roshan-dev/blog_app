class BlogEntity {
  final String id;
  final String posterId;
  final DateTime updatedAt;
  final String title;
  final String content;
  final String imageUrl;
  final String topic;

  BlogEntity({
    required this.id,
    required this.title,
    required this.content,
    required this.imageUrl,
    required this.topic,
    required this.posterId,
    required this.updatedAt,
  });
}
