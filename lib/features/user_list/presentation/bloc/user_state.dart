part of 'user_bloc.dart';

class UserState {
  FormSubmissionStatus? formStatus;
  List<User> users;
  final List<User> filteredUsers;
  bool canPopNow, isSearchVisible;
  bool? checkInternetConnection;
  int mTotalCount;


  UserState({
    this.checkInternetConnection = true,
    this.formStatus = const InitialState(),
    this.users = const [],
    this.filteredUsers = const [],
    this.canPopNow = false,
    this.isSearchVisible = false,
    this.mTotalCount = 0,
  });

  UserState copyWith({
    FormSubmissionStatus? formStatus,
    bool? checkInternetConnection,
    List<User>? users,
    List<User>? filteredUsers,
    bool? canPopNow,
    bool? isSearchVisible,
    int? mTotalCount,
  }) {
    return UserState(
      formStatus: formStatus ?? this.formStatus,
      checkInternetConnection: checkInternetConnection ?? this.checkInternetConnection,
      users: users ?? this.users,
      filteredUsers: filteredUsers ?? this.filteredUsers,
      canPopNow: canPopNow ?? this.canPopNow,
      isSearchVisible: isSearchVisible ?? this.isSearchVisible,
      mTotalCount: mTotalCount ?? this.mTotalCount,
    );
  }
}
