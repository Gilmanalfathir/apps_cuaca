import 'package:flutter/material.dart';

import '/constants/app_colors.dart';

class RoundTextField extends StatelessWidget {
  const RoundTextField({
    super.key,
    this.controller,
    this.onSubmitted,
  });

  final TextEditingController? controller;
  final ValueChanged<String>? onSubmitted;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      decoration: BoxDecoration(
        color: AppColors.royalBlue,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: TextField(
        style: const TextStyle(
          color: AppColors.white,
        ),
        controller: controller,
        onSubmitted: onSubmitted, // Trigger when user presses Enter
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 15.0), // Padding for text
          fillColor: Colors.white,
          focusColor: Colors.white,
          prefixIcon: Icon(
            Icons.search,
            color: AppColors.white,
          ),
          border: InputBorder.none,
          hintText: 'Search',
          hintStyle: TextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
