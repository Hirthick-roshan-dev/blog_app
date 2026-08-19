
import 'package:blog_app/core/local_storage/local_storage.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/auth/presentation/pages/sign_screen.dart';
import 'package:blog_app/features/home/presentation/bloc/blog_home_bloc.dart';
import 'package:blog_app/features/home/presentation/pages/home_screen.dart';
import 'package:blog_app/init_dependency.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencyInjection();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_)=> serviceLocator<AuthBloc>(),
        ),
        BlocProvider(
          create: (_)=> serviceLocator<BlogHomeBloc>(),
        ),
      ],
      child: MyApp(local: serviceLocator()),
    ),
  );
}

class MyApp extends StatefulWidget {
  final LocalDataSource local;
  const MyApp({super.key, required this.local});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool _isLogin = false;

  Future<void> loginStatus() async {
    final status = await widget.local.getLoginStatus();
    setState(() {
      _isLogin = status;
    });
  }


  @override
  void initState() {
    super.initState();
    loginStatus();
  }



  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Blog app',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: _isLogin ? const HomeScreen() : const SignUpScreen(),
    );
  }
}
