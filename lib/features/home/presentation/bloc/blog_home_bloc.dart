import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:blog_app/core/local_storage/local_storage.dart';
import 'package:blog_app/features/home/domain/usecases/upload_blog_usecase.dart';
import 'package:meta/meta.dart';

part 'blog_home_event.dart';
part 'blog_home_state.dart';

class BlogHomeBloc extends Bloc<BlogHomeEvent, BlogHomeState> {
  final UploadBlogUsecase _uploadBlogUsecase;
  final LocalDataSource _dataSource;

  BlogHomeBloc({required UploadBlogUsecase uploadBlogUsecase,required LocalDataSource dataSource})
    : _uploadBlogUsecase = uploadBlogUsecase,
      _dataSource = dataSource,

      super(HomeBlogInitState()) {
    on<AddBlogDataEvent>(addBlog);
  }

  void addBlog(AddBlogDataEvent event, Emitter emit) async {

    final userId = await _dataSource.getUserId();

    emit(AddBlogLoadingState());

    if (userId.isNotEmpty) {
      final response = await _uploadBlogUsecase.call(
          UploadBlogParams(
              posterId: userId,
              title: event.title,
              content: event.content,
              topic: event.topic,
              image: event.image
          )
      );
      response.fold(
          (fail) => emit(AddBlogErrorState(message: fail.message)),
          (added) => emit(AddBlogSuccessState())
      );
    }else{
      emit(AddBlogErrorState(message: "User not found"));
    }
  }
}
