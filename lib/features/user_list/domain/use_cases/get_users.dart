import 'package:codebase/features/user_list/domain/entities/user.dart';
import 'package:codebase/features/user_list/domain/entities/user_params.dart';
import 'package:codebase/features/user_list/domain/repositories/user_repository.dart';

class GetUsers {
  final UserRepository repository;

  GetUsers(this.repository);

  Future<List<User>> call({required UserParams params}) async {
    return await repository.getUsers(
      page: params.page,
      perPage: params.perPage,
    );
  }
}
