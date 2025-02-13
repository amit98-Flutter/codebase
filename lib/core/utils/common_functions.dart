import 'package:codebase/core/theme/app_color.dart';
import 'package:codebase/core/route/app_router.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loader_overlay/loader_overlay.dart';

abstract class CommonFunctions {
  static void showSuccessSnackBar(String message, {Color bgColor = const Color(0xFF66bb6a)}) {
    _showSnackBar(message, bgColor);
  }

  static void showWarningSnackBar(String message, {Color bgColor = const Color(0xFFffa726)}) {
    _showSnackBar(message, bgColor);
  }

  static void showErrorSnackBar(String message, {Color bgColor = const Color(0xfff65c4f)}) {
    _showSnackBar(message, bgColor);
  }

  static void _showSnackBar(String message, Color bgColor) {
    final snackBar = SnackBar(
        content: Text(message, style: const TextStyle(color: AppColors.whiteColor)),
        backgroundColor: bgColor,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2));

    final context = AppRouter.navigatorKey.currentContext;

    if (context != null) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    }
  }

  static showLoader(BuildContext context) {
    context.loaderOverlay.show();
  }

  static dismissLoader(BuildContext context) {
    context.loaderOverlay.hide();
  }

  static BoxDecoration cardDecoration({Color? color, List<BoxShadow>? boxShadow, BorderRadius? borderRadius}) {
    return BoxDecoration(
      color: color ?? AppColors.whiteColor,
      boxShadow: boxShadow ??
          const [
            BoxShadow(offset: Offset(1, 1), blurRadius: 6, color: Color.fromRGBO(0, 0, 0, 0.16)),
          ],
      borderRadius: borderRadius ?? BorderRadius.circular(8.r),
    );
  }

  static Future<bool> checkInternetConnectivity() async {
    List<ConnectivityResult> results = await Connectivity().checkConnectivity();

    // If there are no results, assume no internet
    if (results.isEmpty) {
      return false;
    }

    // Check if any of the results indicate an active connection
    return results.contains(ConnectivityResult.mobile) || results.contains(ConnectivityResult.wifi);
  }
}
