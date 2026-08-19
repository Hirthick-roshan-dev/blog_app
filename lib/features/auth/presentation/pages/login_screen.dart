import 'package:blog_app/core/theme/app_theme.dart';
import 'package:blog_app/core/utils/shared_widgets/app_button.dart';
import 'package:blog_app/core/utils/shared_widgets/app_text.dart';
import 'package:blog_app/core/utils/shared_widgets/app_text_field.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/auth/presentation/pages/sign_screen.dart';
import 'package:blog_app/features/home/presentation/pages/home_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool obscureText = false;

  @override
  void dispose() {
    // TODO: implement dispose
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 20,
              children: [
                SizedBox(height: Get.height * 0.1),
                Center(
                  child: AppText(
                    text: "Login",
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                AppTextField(
                  title: 'Email',
                  controller: _emailController,
                  hintText: 'Enter your Email',
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your email';
                    }
                    final emailRegex = RegExp(
                      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                    );

                    if (!emailRegex.hasMatch(value.trim())) {
                      return 'Please enter a valid email';
                    }

                    return null;
                  },
                ),
                AppTextField(
                  title: 'Password',
                  controller: _passwordController,
                  hintText: 'Enter your password',
                  obscureText: obscureText,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your password';
                    }
                    if (value.trim().length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                  suffixIcon: InkWell(
                    onTap: () {
                      setState(() {
                        obscureText = !obscureText;
                      });
                    },
                    child: Icon(
                      obscureText == false
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: AppColors.grey,
                      size: 25,
                    ),
                  ),
                ),
                SizedBox(),
                BlocConsumer<AuthBloc, AuthStateSign>(
                  listener: (context, state) {

                    if(state is AuthLoginSuccessState){
                      Get.snackbar("Login", "Login Success");
                      Get.to(()=>HomeScreen());
                    }

                    if (state is AuthLoginError) {
                      Get.snackbar(
                        "Error",
                        state.message,
                      );
                    }
                  },
                  builder: (context, state) {
                    return AppButton(
                      text: "Login",
                      isLoading: state is AuthLoginLoadingState,
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          context.read<AuthBloc>().add(
                              AuthLoginEvent(email: _emailController.text.trim(), password: _passwordController.text.trim()));
                        }
                      },
                    );
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: 4,
                  children: [
                    AppText(text: "Don't have account?"),
                    InkWell(
                      onTap: () {
                        Get.offAll(() => SignUpScreen());
                      },
                      child: AppText(
                        text: "Sign up",
                        color: Colors.blue,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
