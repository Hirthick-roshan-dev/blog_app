


import 'package:blog_app/core/app_errors/failer.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class UseCase<SuccessType,Params>{

  Future<Either<Failer,SuccessType>> call(Params params);

}