


import 'package:blog_app/core/app_errors/failer.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/auth/domain/entities/user.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repo.dart';
import 'package:fpdart/fpdart.dart';

class SignUpUseCase implements UseCase<User,SignUpUserData>{
  final AuthDomainRepo authDomainRepo;

  SignUpUseCase(this.authDomainRepo);

  @override
  Future<Either<Failer,User>> call(SignUpUserData params) async {
    return await authDomainRepo.signUpWithEmailAndPassword(name: params.name, email: params.email, password: params.password);
  }

}

class LoginUseCase implements UseCase<User,LoginUserData> {
  final AuthDomainRepo authDomainRepo;

  LoginUseCase(this.authDomainRepo);

  @override
  Future<Either<Failer, User>> call(LoginUserData params)async {
    return await authDomainRepo.loginWithEmailAndPassword(email: params.email, password: params.password);
  }

}

class SignUpUserData {
  final String name;
  final String email;
  final String password;
  SignUpUserData({required this.name,required this.email,required this.password});
}


class LoginUserData {

  final String email;
  final String password;
  LoginUserData({required this.email,required this.password});
}




