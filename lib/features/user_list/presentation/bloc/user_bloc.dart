import 'dart:async';

import 'package:codebase/core/network/api_client.dart';
import 'package:codebase/core/utils/common_functions.dart';
import 'package:codebase/core/utils/form_submission_status.dart';
import 'package:codebase/features/user_list/domain/entities/user.dart';
import 'package:codebase/features/user_list/domain/use_cases/get_users.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final GetUsers getUsers;
  int page = 1;
  int perPage = 10;
  DateTime? currentBackPressTime;
  RefreshController refreshController = RefreshController(initialRefresh: false);


  UserBloc(this.getUsers) : super(UserState()) {
    on<OnInternetConnectionChanged>(_onInternetConnectionChanged);
    on<OnUserListAdded>(_onUserListAdded);
    on<OnCanPopNowChanged>(_onCanPopNowChanged);
    on<OnSearchUsers>(_onSearchUsers);
    on<OnSearchVisibleChanged>(_onSearchVisibleChanged);
    on<OnFetchUsersCalled>(_onFetchUsersCalled);
    on<OnTotalCountChanged>(_onTotalCountChanged);

    //check internet connection//
    Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> result) async {
      bool checkInternet = await CommonFunctions.checkInternetConnectivity();
      add(OnInternetConnectionChanged(checkInternet));
    });
  }

  void _onTotalCountChanged(OnTotalCountChanged event, Emitter<UserState> emit) {
    emit(state.copyWith(mTotalCount: event.mTotalCount));
  }

  void _onInternetConnectionChanged(OnInternetConnectionChanged event, Emitter<UserState> emit) {
    emit(state.copyWith(checkInternetConnection: event.checkInternetConnection));
  }

  void _onSearchVisibleChanged(OnSearchVisibleChanged event, Emitter<UserState> emit) {
    emit(state.copyWith(isSearchVisible: event.isSearchVisible));
  }

  void _onUserListAdded(OnUserListAdded event, Emitter<UserState> emit) {
    emit(state.copyWith(users: event.users));
  }

  void _onCanPopNowChanged(OnCanPopNowChanged event, Emitter<UserState> emit) {
    emit(state.copyWith(canPopNow: event.canPopNow));
  }

  Future<void> _onFetchUsersCalled(OnFetchUsersCalled event, Emitter<UserState> emit) async {
    if (event.isRefreshing == false) {
      emit(state.copyWith(formStatus: const Loading2Status()));
    }
    try {
      final users = await getUsers(page, perPage);
      List<User> updatedUsers = (page == 1)
          ? users  // Reset list if first page
          : [...state.users, ...users]; // Append to existing list

      add(OnUserListAdded(users: updatedUsers));
      emit(state.copyWith(filteredUsers: users));
      add(OnTotalCountChanged(mTotalCount: 12));
    } catch (error) {
      CommonFunctions.showErrorSnackBar(error.toString());
    } finally {
      emit(state.copyWith(formStatus: const InitialState()));
      refreshController.refreshCompleted();
    }
  }

  void onLoadMore(){
    page++;
    add(OnFetchUsersCalled(isLoadMore: true));
  }

  void onRefresh() async {
    add(OnFetchUsersCalled(isRefreshing: true));
  }

  void onPopInvoked(BuildContext context) {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null || now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;

      CommonFunctions.showWarningSnackBar("Press back again to leave");

      Future.delayed(const Duration(seconds: 2), () {
        if (!isClosed) {
          add(OnCanPopNowChanged(false));
        }
      });
      // Ok, let user exit app on the next back press
      if (!isClosed) {
        add(OnCanPopNowChanged(true));
      }
    }
  }

  Future<void> clearCache() async {
    try {
      final apiClient = await ApiClient.create();
      final cacheStore = apiClient.cacheOptions.store;

      if (cacheStore != null) {
        await cacheStore.clean();
        CommonFunctions.showSuccessSnackBar("Cache Cleared Successfully!");
      } else {
        CommonFunctions.showErrorSnackBar("No Cache Found!");
      }
    } catch (e) {
      CommonFunctions.showErrorSnackBar("Failed to Clear Cache: ${e.toString()}");
    }
  }

  void _onSearchUsers(OnSearchUsers event, Emitter<UserState> emit) {
    final query = event.query.toLowerCase();

    if (query.isEmpty) {
      emit(state.copyWith(filteredUsers: state.users)); // Show all users if query is empty
    } else {
      // Filter users based on query
      emit(state.copyWith(
          filteredUsers: state.users.where((user) {
        return user.firstName.toLowerCase().contains(query) || user.lastName.toLowerCase().contains(query);
      }).toList()));
    }
  }

  Future<void> checkInternetConnection() async {
    bool checkInternet = await CommonFunctions.checkInternetConnectivity();
    add(OnInternetConnectionChanged(checkInternet));
    if(!checkInternet){
      CommonFunctions.showErrorSnackBar("No Internet Connection");
    }
  }
}
