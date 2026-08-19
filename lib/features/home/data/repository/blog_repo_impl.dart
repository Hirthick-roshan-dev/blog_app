


import 'dart:io';

import 'package:blog_app/core/app_errors/failer.dart';
import 'package:blog_app/core/app_errors/server_exception.dart';
import 'package:blog_app/features/home/data/data_source/blog_remote_data_source.dart';
import 'package:blog_app/features/home/data/models/blog_model.dart';
import 'package:blog_app/features/home/domain/entities/blog_entity.dart';
import 'package:blog_app/features/home/domain/repository/blog_repo.dart';
import 'package:fpdart/src/either.dart';
import 'package:uuid/uuid.dart';

class BlogRepoImpl implements BlogRepo{

  final BlogRemoteDataSource _blogRemoteDataSource;

  BlogRepoImpl(this._blogRemoteDataSource);


  @override
  Future<Either<Failer, BlogEntity>> uploadBlog({required File image, required String posterId, required String title, required String content, required String topic})async {
    try{
      BlogModel blog = BlogModel(
          id: Uuid().v1(),
          title: title,
          content: content,
          imageUrl: '',
          topic: topic,
          posterId: posterId,
          updatedAt: DateTime.now()
      );
      final imageUrl = await _blogRemoteDataSource.uploadProfileImage(image: image, blog: blog);
      blog = blog.copyWith(imageUrl: imageUrl);
      final response = await _blogRemoteDataSource.addBlog(blog);
      return right(response.toEntity());

    }on ServerException catch (e){
      // print("From the repo ServerException ${e.message}");
      return left(Failer(e.message));
    }
  }

}