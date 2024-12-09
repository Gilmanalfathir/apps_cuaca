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
          contentPadding: const EdgeInsets.symmetric(vertical: 15.0), // Padding for text
          fillColor: Colors.white,
          focusColor: Colors.white,
          prefixIcon: const Icon(
            Icons.search,
            color: AppColors.slate,
          ),
          border: InputBorder.none,
          hintText: 'Search',
          hintStyle: const TextStyle(
            color: AppColors.slate,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
