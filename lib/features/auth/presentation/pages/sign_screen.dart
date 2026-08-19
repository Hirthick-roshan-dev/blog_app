import 'package:blog_app/core/theme/app_theme.dart';
import 'package:blog_app/core/utils/shared_widgets/app_button.dart';
import 'package:blog_app/core/utils/shared_widgets/app_text.dart';
import 'package:blog_app/core/utils/shared_widgets/app_text_field.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/auth/presentation/pages/login_screen.dart';
import 'package:blog_app/features/home/presentation/pages/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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
                    text: "Sign",
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                AppTextField(
                  title: 'Name',
                  controller: _nameController,
                  hintText: 'Enter your name',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
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
                if (state is AuthSuccess) {
                  Get.snackbar(
                    "Login success",
                    "Your profile is created",
                  );
                  Get.to(()=>HomeScreen());
                  _nameController.clear();
                  _emailController.clear();
                  _passwordController.clear();
                }
                if (state is AuthError) {
                  Get.snackbar(
                    "Error",
                    state.message,
                  );
                }
              },
              builder: (context, state) {
                return AppButton(
                  text: "Sign up",
                  isLoading: state is AuthLoading,
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      context.read<AuthBloc>().add(
                        AuthSignUpEvent(
                          name: _nameController.text,
                          email: _emailController.text.trim(),
                          password: _passwordController.text,
                        ),
                      );
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
                    AppText(text: "Already have account?"),
                    InkWell(
                      onTap: () {
                        Get.offAll(() => LoginScreen());
                      },
                      child: AppText(
                        text: "Login",
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
