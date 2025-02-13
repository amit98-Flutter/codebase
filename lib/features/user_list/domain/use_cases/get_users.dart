import 'package:codebase/features/user_list/data/repositories/user_repository.dart';
import 'package:codebase/features/user_list/domain/entities/user.dart';

class GetUsers {
  final UserRepository repository;

  GetUsers(this.repository);

  Future<List<User>> call(int page, int perPage) async {
    return await repository.getUsers(page, perPage);
  }
}