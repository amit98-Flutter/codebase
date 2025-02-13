import 'dart:io';

import 'package:codebase/core/theme/app_color.dart';
import 'package:codebase/core/theme/fonts.dart';
import 'package:codebase/core/utils/app_router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      minTextAdapt: true,
      splitScreenMode: true,
      enableScaleText: () => false,
      builder: (ctx, child) {
        ScreenUtil.init(ctx);
        return GlobalLoaderOverlay(
          overlayColor: Colors.black54,
          overlayWidgetBuilder: (_) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primaryColor,),
            );
          },
          child: RefreshConfiguration(
            headerBuilder: () => WaterDropHeader(
                waterDropColor: AppColors.primaryColor,
                refresh: SizedBox(
                  width: 25.r,
                  height: 25.r,
                  child: Platform.isIOS
                      ? const CupertinoActivityIndicator(color: AppColors.primaryColor)
                      : const CircularProgressIndicator(strokeWidth: 2.0, color: AppColors.primaryColor),
                )),
            footerBuilder: () => const ClassicFooter(),
            maxOverScrollExtent: 100,
            maxUnderScrollExtent: 0,
            enableScrollWhenRefreshCompleted: true,
            enableLoadingWhenFailed: true,
            hideFooterWhenNotFull: false,
            child: MaterialApp.router(
              title: dotenv.get('APP_NAME'),
              theme: ThemeData(useMaterial3: false, fontFamily: FontFamily.fonts),
              debugShowCheckedModeBanner: false,
              routerConfig: AppRouter.router, // Use AppRouter for navigation
            ),
          ),
        );
      },
    );
  }
}
