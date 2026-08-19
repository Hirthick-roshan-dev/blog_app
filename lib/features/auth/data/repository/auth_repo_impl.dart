


import 'package:blog_app/core/app_errors/failer.dart';
import 'package:blog_app/core/app_errors/server_exception.dart';
import 'package:blog_app/core/local_storage/local_storage.dart';
import 'package:blog_app/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:blog_app/features/auth/domain/entities/user.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repo.dart';
import 'package:fpdart/src/either.dart';

class AuthRepoImple implements AuthDomainRepo {

  final AuthRemoteDataSource remoteDataSource ;
  final LocalDataSource local;

  AuthRepoImple(this.remoteDataSource, this.local);

  @override
  Future<Either<Failer, User>> loginWithEmailAndPassword({required String email, required String password})async {
    try{
      final response = await remoteDataSource.loginWithEmailAndPassword(email: email, password: password);
      await local.setUserId(response.id);
      await local.setLoginStatus(true);
      return right(response.toEntity());
    }on ServerException catch(e){
      return left(Failer(e.message));
    }
  }

  @override
  Future<Either<Failer, User>> signUpWithEmailAndPassword({required String name, required String email, required String password})async {
    try{
      final response = await remoteDataSource.signUpWithEmailAndPassword(name: name, email: email, password: password);
      return right(response.toEntity());
    }on ServerException catch(e){
      return left(Failer(e.message));
    }
  }
  
}