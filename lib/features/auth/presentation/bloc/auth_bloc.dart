import 'package:bloc/bloc.dart';
import 'package:blog_app/features/auth/domain/entities/user.dart';
import 'package:blog_app/features/auth/domain/usecase/auth_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthStateSign> {
  final SignUpUseCase _useCase;
  final LoginUseCase _loginUseCase;

  AuthBloc({ required SignUpUseCase useCase, required LoginUseCase loginUseCase})
    : _useCase = useCase,
      _loginUseCase = loginUseCase,
      super(AuthInitial()) {
    on<AuthSignUpEvent>((event, emit) async {


      emit(AuthLoading());


      final response = await _useCase.call(
        SignUpUserData(
          name: event.name,
          email: event.email,
          password: event.password,
        ),
      );

      response.fold(
        (fail)  => emit(AuthError(message: fail.message)),
        (user) => emit(AuthSuccess(user: user)),
      );
    });

    on<AuthLoginEvent>((event, emit) async {
      emit(AuthLoginLoadingState());

      final response = await _loginUseCase.call(
        LoginUserData(email: event.email, password: event.password),
      );
      response.fold(
        (error) => emit(AuthLoginError(message: error.message)),
        (user) => emit(AuthLoginSuccessState(user: user)),
      );
    });
  }
}
