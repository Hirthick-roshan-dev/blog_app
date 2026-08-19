part of 'blog_home_bloc.dart';

@immutable
sealed class BlogHomeEvent {}

class AddBlogDataEvent extends BlogHomeEvent{

  final String title;
  final String content;
  final String topic;
  final File image;

  AddBlogDataEvent({required this.title,required this.content,required this.topic,required this.image});
}
