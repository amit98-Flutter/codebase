import 'package:codebase/core/theme/app_color.dart';
import 'package:codebase/core/widget/custom_app_bar.dart';
import 'package:codebase/features/user_list/presentation/bloc/user_bloc.dart';
import 'package:codebase/features/user_list/presentation/screens/user_list_view.dart';
import 'package:codebase/features/user_list/presentation/widgets/no_internet_view.dart';
import 'package:codebase/features/user_list/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserListPage extends StatelessWidget {
  const UserListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => slUser<UserBloc>(), //Use DI
      child: BlocListener<UserBloc, UserState>(
        listener: (context, state) {
          // if (state.formStatus is LoadingStatus) {
          //   CommonFunctions.showLoader(context);
          // } else {
          //   CommonFunctions.dismissLoader(context);
          // }
        },
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            return PopScope(
              canPop: state.canPopNow,
              onPopInvokedWithResult: (didPop, dynamic) async {
                return context.read<UserBloc>().onPopInvoked(context);
              },
              child: state.checkInternetConnection! ? Scaffold(
                backgroundColor: AppColors.backgroundColor,
                appBar:  CustomAppBar(
                  screenName: "UsersList",
                  isShowBackBtn: false,
                  centerTitle: false,
                  onSearchChanged: (query){
                    context.read<UserBloc>().add(OnSearchUsers(query: query));
                  },
                  onSearchVisibilityChanged: (bool isVisible){
                    context.read<UserBloc>().add(OnSearchVisibleChanged(isVisible));
                  },
                ),
                body: const UserListView(),
              ) : const NoInternetView(),
            );
          },
        ),
      ),
    );
  }
}
