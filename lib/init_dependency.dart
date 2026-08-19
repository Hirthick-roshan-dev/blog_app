import 'package:blog_app/core/local_storage/local_storage.dart';
import 'package:blog_app/core/secrets/app_secrets.dart';
import 'package:blog_app/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:blog_app/features/auth/data/repository/auth_repo_impl.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repo.dart';
import 'package:blog_app/features/auth/domain/usecase/auth_usecase.dart';
import 'package:blog_app/features/home/data/data_source/blog_remote_data_source.dart';
import 'package:blog_app/features/home/data/repository/blog_repo_impl.dart';
import 'package:blog_app/features/home/domain/repository/blog_repo.dart';
import 'package:blog_app/features/home/domain/usecases/upload_blog_usecase.dart';
import 'package:blog_app/features/home/presentation/bloc/blog_home_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'features/auth/presentation/bloc/auth_bloc.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencyInjection() async {
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseAnonKey,
  );

  final SharedPreferences? local = await LocalDataSource.initLocalDataSource();
  serviceLocator.registerSingleton<SupabaseClient>(supabase.client);
  serviceLocator.registerSingleton(LocalDataSource());
  serviceLocator.registerSingleton(local!);


  _initAuth();
  _blogHome();
}

void _initAuth() {
  serviceLocator
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(serviceLocator()),
    )
    ..registerFactory<AuthDomainRepo>(() => AuthRepoImple(serviceLocator(),serviceLocator()))
    ..registerFactory(() => SignUpUseCase(serviceLocator()))
    ..registerFactory(() => LoginUseCase(serviceLocator()))
    ..registerLazySingleton(
      () => AuthBloc(useCase: serviceLocator(), loginUseCase: serviceLocator()),
    );
}


void _blogHome() {
  serviceLocator
    ..registerFactory<BlogRemoteDataSource>(
          () => BlogRemoteDataSourceImpl(serviceLocator()),
    )
      ..registerFactory<BlogRepo>(() => BlogRepoImpl(serviceLocator()))
      .. registerFactory(()=> UploadBlogUsecase(serviceLocator()))
      .. registerLazySingleton(
            () => BlogHomeBloc(uploadBlogUsecase: serviceLocator(), dataSource: serviceLocator()),
      );
}
