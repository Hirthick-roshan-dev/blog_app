part of 'auth_bloc.dart';


sealed class AuthStateSign {}

final class AuthInitial extends AuthStateSign {}

final class AuthLoading extends AuthStateSign {}

final class AuthSuccess extends AuthStateSign {
  final User user;
  AuthSuccess({required this.user});
}

final class AuthError extends AuthStateSign{

  final String message;
  AuthError({required this.message});

}

class AuthLoginLoadingState extends AuthStateSign {}

final class AuthLoginError extends AuthStateSign{

  final String message;
  AuthLoginError({required this.message});

}

class AuthLoginSuccessState extends AuthStateSign {
  final User user;
  AuthLoginSuccessState({required this.user});
}
