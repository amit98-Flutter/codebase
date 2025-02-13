import 'package:codebase/core/theme/font_weights.dart';
import 'package:codebase/core/theme/fonts.dart';
import 'package:flutter/material.dart';

import 'app_color.dart';
import 'app_size.dart';


class AppTextStyle extends TextStyle {
  final FontWeight fontWeight;
  final double fontSize;
  final Color color;
  final String? fontFamily;

  const AppTextStyle._({required this.fontWeight, required this.fontSize, required this.color, this.fontFamily})
      : super(
          fontWeight: fontWeight,
          fontSize: fontSize,
          color: color,
          fontFamily: fontFamily,
        );

  factory AppTextStyle.regular400({
    double? fontSize,
    Color color = AppColors.headlineTextColor,
    String? fontFamily,
  }) {
    return AppTextStyle._(
      fontWeight: AppFontWeights.regular,
      fontSize: fontSize ?? AppSize.fontSize14,
      color: color,
      fontFamily: fontFamily ?? FontFamily.fonts,
    );
  }


  factory AppTextStyle.medium500({
    double? fontSize,
    Color color = AppColors.headlineTextColor,
    String? fontFamily,
  }) {
    return AppTextStyle._(
      fontWeight: AppFontWeights.medium,
      fontSize: fontSize ?? AppSize.fontSize14,
      color: color,
      fontFamily: fontFamily ?? FontFamily.fonts,
    );
  }

  /// Factory constructor to create a [semibold600] text style.
  ///
  /// [fontSize] is the size of the text. Default is [AppSize.fontSize14].
  /// [color] is the color of the text. Default is [AppColors.headlineTextColor].
  /// [fontFamily] is the font family. Default is 'Noto Sans'.
  factory AppTextStyle.semiBold600({
    double? fontSize,
    Color color = AppColors.headlineTextColor,
    String? fontFamily,
  }) {
    return AppTextStyle._(
      fontWeight: AppFontWeights.semiBold,
      fontSize: fontSize ?? AppSize.fontSize14,
      color: color,
      fontFamily: fontFamily ?? FontFamily.fonts,
    );
  }

  /// Factory constructor to create a [bold700] text style.
  ///
  /// [fontSize] is the size of the text. Default is [AppSize.fontSize14].
  /// [color] is the color of the text. Default is [AppColors.headlineTextColor].
  /// [fontFamily] is the font family. Default is 'Noto Sans'.
  factory AppTextStyle.bold700({
    double? fontSize,
    Color color = AppColors.headlineTextColor,
    String? fontFamily,
  }) {
    return AppTextStyle._(
      fontWeight: AppFontWeights.bold,
      fontSize: fontSize ?? AppSize.fontSize14,
      color: color,
      fontFamily: fontFamily ?? FontFamily.fonts,
    );
  }
}
