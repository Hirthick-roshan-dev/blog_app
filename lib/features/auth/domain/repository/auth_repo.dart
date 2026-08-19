

import 'package:blog_app/core/app_errors/failer.dart';
import 'package:blog_app/features/auth/domain/entities/user.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthDomainRepo{

  Future<Either<Failer,User>> signUpWithEmailAndPassword({required String name,required String email,required String password});
  Future<Either<Failer,User>> loginWithEmailAndPassword({required String email,required String password});
  
}