import 'package:equatable/equatable.dart';

class UserParams extends Equatable {
  final int page;
  final int perPage;

  const UserParams(this.page, this.perPage);
  @override
  List<Object?> get props => [page, perPage];
}