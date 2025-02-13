
import 'package:codebase/core/theme/app_color.dart';
import 'package:codebase/core/theme/fonts.dart';
import 'package:codebase/core/route/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loader_overlay/loader_overlay.dart';

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
          child: MaterialApp.router(
            title: dotenv.get('APP_NAME'),
            theme: ThemeData(useMaterial3: false, fontFamily: FontFamily.fonts),
            debugShowCheckedModeBanner: false,
            routerConfig: AppRouter.router, // Use AppRouter for navigation
          ),
        );
      },
    );
  }
}
