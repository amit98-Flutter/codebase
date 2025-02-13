import 'package:codebase/core/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerUserCard extends StatelessWidget {
  const ShimmerUserCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Shimmer.fromColors(
        baseColor: AppColors.baseColor,
        highlightColor: AppColors.highlightColor,
        child: Container(
          height: 50.r,
          width: 50.r,
          decoration: BoxDecoration(color: AppColors.whiteColor, borderRadius: BorderRadius.circular(100)),
        ),
      ),
      title: Shimmer.fromColors(
        baseColor: AppColors.baseColor,
        highlightColor: AppColors.highlightColor,
        child: Container(height: 12.h, color: AppColors.whiteColor),
      ),
      subtitle: Shimmer.fromColors(
        baseColor: AppColors.baseColor,
        highlightColor: Colors.grey[100]!,
        child: Container(height: 10.h, color: AppColors.whiteColor),
      ),
    );
  }
}
