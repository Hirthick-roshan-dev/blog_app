part of 'blog_home_bloc.dart';


sealed class BlogHomeState {}

class HomeBlogInitState extends BlogHomeState {}

class AddBlogLoadingState extends BlogHomeState {}

class AddBlogSuccessState extends BlogHomeState{}

class AddBlogErrorState extends BlogHomeState{
  final String message;
  AddBlogErrorState({required this.message});
}