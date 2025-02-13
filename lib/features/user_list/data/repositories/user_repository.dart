
import 'package:codebase/features/user_list/data/data_sources/user_remote_data_source.dart';
import 'package:codebase/features/user_list/domain/entities/user.dart';

class UserRepository {
  final UserRemoteDataSource remoteDataSource;

  UserRepository(this.remoteDataSource);

  Future<List<User>> getUsers(int page, int perPage) async {
    return await remoteDataSource.fetchUsers(page, perPage);
  }
}