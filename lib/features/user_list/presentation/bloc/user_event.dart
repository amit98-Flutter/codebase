part of 'user_bloc.dart';

abstract class UserEvent {
  const UserEvent();
}

class OnFetchUsersCalled extends UserEvent {
  OnFetchUsersCalled({this.isRefreshing = false, this.isLoadMore = false});

  final bool? isRefreshing;
  final bool? isLoadMore;
}

class OnUserListAdded extends UserEvent {
  const OnUserListAdded({required this.users});

  final List<User> users;
}

class OnCanPopNowChanged extends UserEvent {
  OnCanPopNowChanged(this.canPopNow);

  final bool? canPopNow;
}

class OnSearchVisibleChanged extends UserEvent {
  OnSearchVisibleChanged(this.isSearchVisible);

  final bool? isSearchVisible;
}

class OnSearchUsers extends UserEvent {
  final String query;

  OnSearchUsers({required this.query});
}

class OnTotalCountChanged extends UserEvent {
  final int mTotalCount;

  OnTotalCountChanged({required this.mTotalCount});
}

class OnInternetConnectionChanged extends UserEvent {
  OnInternetConnectionChanged(this.checkInternetConnection);

  final bool checkInternetConnection;

  List<Object> get props => [checkInternetConnection];
}
