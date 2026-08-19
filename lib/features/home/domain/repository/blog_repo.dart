

import 'dart:io';

import 'package:blog_app/core/app_errors/failer.dart';
import 'package:blog_app/features/home/domain/entities/blog_entity.dart';
import 'package:fpdart/fpdart.dart';

abstract class BlogRepo {
  Future<Either<Failer,BlogEntity>> uploadBlog({
    required File image,
    required String posterId,
    required String title,
    required String content,
    required String topic

});
}