import 'dart:io';

import 'package:blog_app/core/app_errors/server_exception.dart';
import 'package:blog_app/features/home/data/models/blog_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class BlogRemoteDataSource {
  Future<BlogModel> addBlog(BlogModel blog);
  Future<String> uploadProfileImage({
    required File image,
    required BlogModel blog,
  });
}

class BlogRemoteDataSourceImpl implements BlogRemoteDataSource {
  final SupabaseClient _supabaseClient;

  BlogRemoteDataSourceImpl(this._supabaseClient);

  @override
  Future<BlogModel> addBlog(BlogModel blog) async {
    try {
      final response = await _supabaseClient
          .from('blogs')
          .insert(blog.toJson())
          .select();
      return BlogModel.fromJson(response.first);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<String> uploadProfileImage({
    required File image,
    required BlogModel blog,
  }) async {
    try {
      await _supabaseClient.storage.from("blog_images").upload(blog.id, image);

      final imageUrl = _supabaseClient.storage
          .from("blog_images")
          .getPublicUrl(blog.id);

      return imageUrl;
    } catch (e) {

      throw ServerException(message: e.toString());
    }
  }
}
