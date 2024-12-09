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
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [        
              AppColors.darkblue.withOpacity(0.80),   
              AppColors.steelblue.withOpacity(0.85),     
              AppColors.lightblue.withOpacity(0.90),     
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
