import 'package:blog_app/core/utils/shared_widgets/app_text.dart';
import 'package:flutter/material.dart';

class AppButton extends StatefulWidget {
  final String text;
  final bool isLoading;
  final bool isEnable;
  final Function()? onTap;

  const AppButton({
    super.key,
    required this.text,
    required this.isLoading,
    required this.onTap,
    this.isEnable = true,
  });

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {

        if (widget.isLoading) {

          return;
        }
        widget.onTap!();
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: widget.isEnable ? Colors.black : Colors.grey.shade400,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Center(
            child: widget.isLoading
                ? SizedBox(
                    height: 25,
                    width: 25,
                    child: const CircularProgressIndicator(color: Colors.white),
                  )
                : AppText(
                    text: widget.text,
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
          ),
        ),
      ),
    );
  }
}
