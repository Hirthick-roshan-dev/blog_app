import 'package:blog_app/core/theme/app_theme.dart';
import 'package:blog_app/core/utils/shared_widgets/app_text.dart';
import 'package:blog_app/features/home/presentation/pages/add_new_blog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const AppText(
          text: "Blog App",
          fontWeight: FontWeight.w600,
          fontSize: 24,
          color: AppColors.white,
        ),
        backgroundColor: AppColors.primary,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => AddNewBlog());
            },
            icon: Icon(
              CupertinoIcons.add_circled,
              color: AppColors.white,
              size: 30,
            ),
          ),
        ],
      ),
      body: Container(
        color: Colors.amber,
        height: Get.height,
        width: Get.width,
      ),
    );
  }
}
