import 'package:codebase/core/theme/app_color.dart';
import 'package:codebase/core/theme/app_size.dart';
import 'package:codebase/core/theme/text_styles.dart';
import 'package:codebase/core/widget/custom_app_button.dart';
import 'package:codebase/features/user_list/domain/entities/user.dart';
import 'package:codebase/features/user_list/presentation/bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class NoInternetView extends StatelessWidget {
  const NoInternetView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.backgroundColor,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(child: Lottie.asset("assets/lottie/no_internet.json", fit: BoxFit.cover, height: 180.h)),
              Text("No Internet Connection.\nPlease try again.",
                  textAlign: TextAlign.center,
                  style: AppTextStyle.regular400(color: AppColors.headlineTextColor, fontSize: AppSize.fontSize12)),
              SizedBox(
                  width: 110.w,
                  child: CustomAppButton(
                    title: "Retry",
                    topMargin: 40,
                    buttonHeight: 30,
                    onButtonTap: () {
                      context.read<UserBloc>().checkInternetConnection();
                    },
                    isDisable: false,
                  ))
            ],
          ),
        );
      },
    );
  }
}
