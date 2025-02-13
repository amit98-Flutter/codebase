import 'package:codebase/features/user_list/domain/entities/user.dart';

abstract class UserRepository {
  Future<List<User>> getUsers({required int page, required int perPage});
}
