import 'package:cached_network_image/cached_network_image.dart';
import 'package:codebase/core/theme/app_color.dart';
import 'package:codebase/core/theme/app_size.dart';
import 'package:codebase/core/theme/text_styles.dart';
import 'package:codebase/core/widget/custom_app_bar.dart';
import 'package:codebase/core/widget/custom_app_button.dart';
import 'package:codebase/core/widget/vertical_spacer.dart';
import 'package:codebase/features/user_list/domain/entities/user.dart';
import 'package:codebase/features/user_list/presentation/bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class UserDetailView extends StatelessWidget {
  final User user;

  const UserDetailView({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.backgroundColor,
          appBar: CustomAppBar(
            screenName: "${user.firstName} ${user.lastName}",
            onBackClick: () {
              if (context.canPop()) {
                context.pop();
              } else {
                context.go("/"); // Navigate to home if there's nothing to pop
              }
            },
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Hero(
                      tag: "user_avatar_${user.id}",
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                          height: 150.r,
                          width: 150.r,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: AppColors.backBgColor),
                          child: ClipRRect(
                            borderRadius: const BorderRadius.all(Radius.circular(100.0)),
                            child: CachedNetworkImage(
                              imageUrl: user.avatar.isNotEmpty ? user.avatar : "",
                              fit: BoxFit.cover,
                              errorWidget: (context, url, error) {
                                return Padding(padding: REdgeInsets.all(25.0), child: Image.asset("assets/icons/icon_placeholder.png"));
                              },
                              placeholder: (context, url) {
                                return Padding(
                                    padding: REdgeInsets.all(25.0),
                                    child: Image.asset("assets/icons/icon_placeholder.png", fit: BoxFit.fill));
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    VerticalSpacer(height: 16.h),
                    Text(
                      "${user.firstName} ${user.lastName}",
                      textAlign: TextAlign.start,
                      style: AppTextStyle.medium500().copyWith(color: AppColors.headlineTextColor, fontSize: AppSize.fontSize14),
                    ),
                    VerticalSpacer(height: 8.h),
                    Text(
                      user.email,
                      textAlign: TextAlign.start,
                      style: AppTextStyle.regular400().copyWith(color: AppColors.detailsTextColor, fontSize: AppSize.fontSize12),
                    ),
                  ],
                ),
                CustomAppButton(
                  title: "Clear Cache",
                  onButtonTap: () {
                    context.read<UserBloc>().clearCache();
                  },
                  isDisable: false,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
