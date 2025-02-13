import 'package:codebase/core/theme/app_color.dart';
import 'package:codebase/core/theme/app_size.dart';
import 'package:codebase/core/theme/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppButton extends StatelessWidget {
  final String title;
  final bool isDisable;
  final VoidCallback onButtonTap;
  final double buttonHeight;
  final bool isShowBorder;
  final Color bgColor;
  final Color borderColor;
  final double rightMargin;
  final double leftMargin;
  final double topMargin;
  final double bottomMargin;
  final double borderWidth;
  final double topLeftRadius;
  final double topRightRadius;
  final double bottomLeftRadius;
  final double bottomRightRadius;
  final Widget? leadingWidget;
  final Widget? trailingWidget;
  final FontWeight fontWeight;
  final Color textColor;
  final double? fontSize;

  const CustomAppButton({
    super.key,
    required this.title,
    required this.onButtonTap,
    required this.isDisable,
    this.leadingWidget,
    this.trailingWidget,
    this.buttonHeight = 45,
    this.isShowBorder = false,
    this.bgColor = AppColors.primaryColor,
    this.borderColor = AppColors.primaryColor,
    this.rightMargin = 18,
    this.leftMargin = 18,
    this.topMargin = 16,
    this.bottomMargin = 16,
    this.borderWidth = 1,
    this.topLeftRadius = 8.0,
    this.topRightRadius = 8.0,
    this.bottomLeftRadius = 8.0,
    this.bottomRightRadius = 8.0,
    this.fontWeight = FontWeight.w600,
    this.textColor = AppColors.headlineTextColor,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: rightMargin.w, left: leftMargin.w, top: topMargin.h, bottom: bottomMargin.h),
      height: buttonHeight.h,
      child: ElevatedButton(
        onPressed: isDisable ? null : onButtonTap,
        style: ElevatedButton.styleFrom(
            backgroundColor: isShowBorder ? Colors.white : (isDisable ? AppColors.buttonDisabledBgColor : bgColor),
            foregroundColor: textColor,
            disabledForegroundColor: AppColors.buttonDisabledBgColor,
            side: isShowBorder ? BorderSide(color: isDisable ? AppColors.buttonDisabledBgColor : borderColor, width: borderWidth) : null,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(topLeftRadius.r),
                  topRight: Radius.circular(topRightRadius.r),
                  bottomLeft: Radius.circular(bottomLeftRadius.r),
                  bottomRight: Radius.circular(bottomRightRadius.r)),
            ),
            textStyle: AppTextStyle.medium500().copyWith(fontWeight: fontWeight, fontSize: fontSize ?? AppSize.fontSize16),
            elevation: 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (leadingWidget != null) leadingWidget!,
            Text(
              title,
              textAlign: TextAlign.center,
              style: isShowBorder
                  ? AppTextStyle.medium500().copyWith(color: isDisable ? AppColors.buttonDisabledBgColor : textColor)
                  : AppTextStyle.medium500().copyWith(color: textColor),
            ),
            if (trailingWidget != null) trailingWidget!,
          ],
        ),
      ),
    );
  }
}
