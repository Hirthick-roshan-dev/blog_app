


import 'dart:io';

import 'package:blog_app/core/app_errors/failer.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/home/domain/entities/blog_entity.dart';
import 'package:blog_app/features/home/domain/repository/blog_repo.dart';
import 'package:fpdart/src/either.dart';

class UploadBlogUsecase implements UseCase<BlogEntity,UploadBlogParams>{

  final BlogRepo _blogRepo;

  UploadBlogUsecase(this._blogRepo);

  @override
  Future<Either<Failer, BlogEntity>> call(UploadBlogParams params) async{
    return await _blogRepo.uploadBlog(image: params.image, posterId: params.posterId, title: params.title, content: params.content, topic: params.topic);
  }

}

class UploadBlogParams{
  final File image;
  final String posterId;
  final String title;
  final String content;
  final String topic;

  UploadBlogParams({required this.posterId,required this.title,required this.content,required this.topic, required this.image});

}