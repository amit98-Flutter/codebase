import 'package:codebase/features/user_list/data/data_sources/user_remote_data_source.dart';
import 'package:codebase/features/user_list/domain/entities/user.dart';
import 'package:codebase/features/user_list/domain/repositories/user_repository.dart';

class UserRepositoryImpl extends UserRepository {
  final UserRemoteDataSource remoteDataSource;

  UserRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<User>> getUsers({required int page, required int perPage}) async {
    return await remoteDataSource.fetchUsers(page, perPage);
  }
}
