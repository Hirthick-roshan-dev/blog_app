import 'dart:io';

import 'package:blog_app/core/local_storage/local_storage.dart';
import 'package:blog_app/core/theme/app_theme.dart';
import 'package:blog_app/core/utils/shared_widgets/app_button.dart';
import 'package:blog_app/core/utils/shared_widgets/app_text.dart';
import 'package:blog_app/core/utils/shared_widgets/app_text_field.dart';
import 'package:blog_app/features/home/presentation/bloc/blog_home_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';

class AddNewBlog extends StatefulWidget {
  const AddNewBlog({super.key});

  @override
  State<AddNewBlog> createState() => _AddNewBlogState();
}

class _AddNewBlogState extends State<AddNewBlog> {
  final List<String> categories = [
    'Technology',
    'Business',
    'Programming',
    'Entertainment',
    'Lifestyle',
    'Health & Fitness',
    'Food',
    'Travel',
    'Personal Development',
    'Fashion',
    'Gaming',
    'Science',
    'Sports',
    'Marketing',
    'DIY & Crafts',
  ];

  String selectedCategory = 'Technology';
  File? selectedImage;


  Future<void> selectImage() async {
    final resource = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (resource != null) {
      setState(() {
        selectedImage = File(resource.path);
      });
    }
  }

  final TextEditingController _topicController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _topicController.dispose();
    _descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const AppText(
          text: "Add blog",
          fontWeight: FontWeight.w600,
          fontSize: 24,
          color: AppColors.white,
        ),
        backgroundColor: AppColors.primary,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(CupertinoIcons.back, color: AppColors.white, size: 30),
        ),

        actions: [],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            spacing: 30,
            children: [
              SizedBox(height: Get.height * 0.05),
              selectedImage == null
                  ? GestureDetector(
                onTap: () {
                  selectImage();
                },
                child: Container(
                  height: Get.height * 0.25,
                  width: Get.width,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey, width: 1),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    spacing: 20,
                    children: [
                      Icon(
                        CupertinoIcons.folder_fill_badge_plus,
                        color: Colors.grey,
                        size: 50,
                      ),
                      AppText(
                        text: "Add your image",
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primary,
                      ),
                    ],
                  ),
                ),
              )
                  : GestureDetector(
                onTap: () {
                  selectImage();
                },
                child: Container(
                  height: Get.height * 0.25,
                  width: Get.width,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey, width: 1),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.file(selectedImage!, fit: BoxFit.cover),
                  ),
                ),
              ),

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  spacing: 10,
                  children: List.generate(categories.length, (category) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedCategory = categories[category];
                        });
                      },
                      child: categoryChip(
                        category: categories[category],
                        isSelected: selectedCategory == categories[category],
                      ),
                    );
                  }),
                ),
              ),

              AppTextField(
                title: "Topic",
                controller: _topicController,
                hintText: "Enter your topic here",
              ),
              AppTextField(
                title: "Description",
                hintText: "Enter your description here..",
                controller: _descriptionController,
                maxLines: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: BlocConsumer<BlogHomeBloc, BlogHomeState>(
                  listener: (context, state) {
                    if (state is AddBlogSuccessState) {
                      Get.snackbar("Success", "Blog added successfully");
                    }
                    if (state is AddBlogErrorState) {
                      Get.snackbar("Error", state.message);
                    }
                  },
                  builder: (context, state) {
                    return AppButton(
                      text: "Upload",
                      isLoading: state is AddBlogLoadingState,
                      onTap: () {

                        if(selectedImage != null &&
                            _topicController.text.isNotEmpty &&
                            _descriptionController.text.isNotEmpty){

                          context.read<BlogHomeBloc>().add(
                              AddBlogDataEvent(title: _topicController.text, content: _descriptionController.text, topic: selectedCategory, image: selectedImage!)
                          );

                        }

                      },
                      isEnable: (selectedImage != null &&
                          _topicController.text.isNotEmpty &&
                          _descriptionController.text.isNotEmpty),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget categoryChip({required String category, required bool isSelected}) {
  return Container(
    decoration: BoxDecoration(
      color: isSelected ? AppColors.primary : Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(
        color: isSelected ? AppColors.primary : Colors.grey,
        width: 1,
      ),
    ),
    child: Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
        child: AppText(
          text: category,
          fontSize: 16,
          color: isSelected ? AppColors.white : AppColors.primary,
        ),
      ),
    ),
  );
}
