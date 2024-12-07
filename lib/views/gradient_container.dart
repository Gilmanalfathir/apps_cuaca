import 'package:flutter/material.dart';

import '/constants/app_colors.dart';

class GradientContainer extends StatelessWidget {
  const GradientContainer({
    super.key,
    required this.children,
  });

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
        height: screenSize.height,
        width: screenSize.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [
              AppColors.obsidian,
              AppColors.charcoal,
              AppColors.charcoal.withOpacity(.99),
              AppColors.charcoal.withOpacity(.98),
              AppColors.charcoal.withOpacity(.97),
              AppColors.charcoal.withOpacity(.96),
              AppColors.charcoal.withOpacity(.95),
              AppColors.charcoal.withOpacity(.94),
              AppColors.charcoal.withOpacity(.93),
              AppColors.charcoal.withOpacity(.92),
              AppColors.charcoal.withOpacity(.91),
              AppColors.charcoal.withOpacity(.90),
              AppColors.navyBlue,
              AppColors.royalBlue,
              AppColors.skyBlue,
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 24.0,
            right: 24.0,
            top: 36.0,
          ),
          child: CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildListDelegate(
                  children,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
