import 'package:codebase/features/user_list/domain/entities/user.dart';
import 'package:codebase/features/user_list/presentation/bloc/user_bloc.dart';
import 'package:codebase/features/user_list/presentation/screens/user_detail_view.dart';
import 'package:codebase/features/user_list/presentation/screens/user_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    navigatorKey: navigatorKey, // Set navigator key here
    routes: [
      GoRoute(
        path: "/",
        builder: (context, state) => const UserListPage(),
      ),
      GoRoute(
        path: "/userDetail/:id",
        builder: (context2, state) {
          final extra = state.extra as Map<String, dynamic>;  // Retrieve user from extra
          final user = extra['user'] as User;
          final context = extra['context'] as BuildContext;
          return BlocProvider.value(
            value: BlocProvider.of<UserBloc>(context), // Provide the existing UserBloc
            child: UserDetailView(user: user),
          );
        },
      ),
    ],
  );
}
