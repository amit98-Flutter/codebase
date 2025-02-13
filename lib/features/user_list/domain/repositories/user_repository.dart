import 'package:codebase/features/user_list/data/models/user_response.dart';

abstract class UserRepository {
  Future<UserResponse> getUsers({required int page, required int perPage});
}
