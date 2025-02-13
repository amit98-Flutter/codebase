import 'package:codebase/features/user_list/data/data_sources/user_remote_data_source.dart';
import 'package:codebase/features/user_list/data/models/user_response.dart';
import 'package:codebase/features/user_list/domain/repositories/user_repository.dart';

class UserRepositoryImpl extends UserRepository {
  final UserRemoteDataSource remoteDataSource;

  UserRepositoryImpl({required this.remoteDataSource});

  @override
  Future<UserResponse> getUsers({required int page, required int perPage}) async {
    return await remoteDataSource.fetchUsers(page, perPage);
  }
}
