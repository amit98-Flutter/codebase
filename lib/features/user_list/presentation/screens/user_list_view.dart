import 'package:codebase/core/utils/form_submission_status.dart';
import 'package:codebase/core/widget/vertical_spacer.dart';
import 'package:codebase/features/user_list/presentation/bloc/user_bloc.dart';
import 'package:codebase/features/user_list/presentation/widgets/no_data_view.dart';
import 'package:codebase/features/user_list/presentation/widgets/shimmer_user_card.dart';
import 'package:codebase/features/user_list/presentation/widgets/user_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

class UserListView extends StatefulWidget {
  const UserListView({super.key});

  @override
  State<UserListView> createState() => _UserListViewState();
}

class _UserListViewState extends State<UserListView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<UserBloc>().add(OnFetchUsersCalled());
    // _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 100) {
      // Trigger pagination when the user is close to the bottom
      context.read<UserBloc>().onLoadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state.formStatus is Loading2Status) {
          return ListView.separated(
            itemCount: 10, // Show 10 shimmer placeholders
            padding: REdgeInsets.all(8),
            separatorBuilder: (_, __) => VerticalSpacer(height: 12.h),
            itemBuilder: (_, __) => const ShimmerUserCard(),
          );
        }

        return state.filteredUsers.isNotEmpty
            ? LazyLoadScrollView(
                onEndOfPage: () {
                  context.read<UserBloc>().onLoadMore();
                },
                child: ListView.separated(
                    scrollDirection: Axis.vertical,
                    controller: _scrollController,
                    itemCount: state.filteredUsers.length,
                    padding: REdgeInsets.all(8),
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) => UserCard(index: index),
                    separatorBuilder: (BuildContext context, int index) {
                      return VerticalSpacer(height: 12.h);
                    }),
              )
            : const NoDataView();
      },
    );
  }
}
