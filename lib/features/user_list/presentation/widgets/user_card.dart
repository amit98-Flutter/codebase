import 'package:cached_network_image/cached_network_image.dart';
import 'package:codebase/core/theme/app_color.dart';
import 'package:codebase/core/theme/app_size.dart';
import 'package:codebase/core/theme/text_styles.dart';
import 'package:codebase/core/utils/common_functions.dart';
import 'package:codebase/features/user_list/presentation/bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class UserCard extends StatelessWidget {
  final int index;

  const UserCard({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return Container(
          decoration: CommonFunctions.cardDecoration(),
          padding: EdgeInsets.symmetric(vertical: 8.h,),
          margin: EdgeInsets.symmetric(horizontal: 8.h),
          child: ListTile(
            leading: Hero(
              tag: "user_avatar_${state.filteredUsers[index].id}",
              child: Container(
                height: 50.r,
                width: 50.r,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: AppColors.backBgColor),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(100.0)),
                  child: CachedNetworkImage(
                    imageUrl: state.filteredUsers[index].avatar.isNotEmpty ? state.filteredUsers[index].avatar : "",
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) {
                      return Padding(padding: REdgeInsets.all(25.0), child: Image.asset("assets/icons/icon_placeholder.png"));
                    },
                    placeholder: (context, url) {
                      return Padding(
                          padding: REdgeInsets.all(25.0), child: Image.asset("assets/icons/icon_placeholder.png", fit: BoxFit.fill));
                    },
                  ),
                ),
              ),
            ),
            title: Text(
              "${state.filteredUsers[index].firstName} ${state.filteredUsers[index].lastName}",
              textAlign: TextAlign.start,
              style: AppTextStyle.medium500(color: AppColors.headlineTextColor, fontSize: AppSize.fontSize14),
            ),
            onTap: () {
              context.push("/userDetail/${state.filteredUsers[index].id}", extra: {'user': state.filteredUsers[index], 'context': context});
            },
          ),
        );
      },
    );
  }
}
