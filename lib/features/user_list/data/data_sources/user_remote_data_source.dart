import 'package:codebase/core/network/api_client.dart';
import 'package:codebase/core/network/api_constants.dart';
import 'package:codebase/core/network/api_service.dart';
import 'package:codebase/core/utils/common_functions.dart';
import 'package:codebase/features/user_list/data/models/user_model.dart';
import 'package:codebase/features/user_list/data/models/user_response.dart';

class UserRemoteDataSource {
  final ApiClient apiClient;

  UserRemoteDataSource(this.apiClient);

  Future<UserResponse> fetchUsers(int page, int perPage) async {
    try {
      final response = await apiClient.get(ApiConstants.users, params: {'per_page': perPage, 'page': page});

      if (response.data != null) {
        final List<dynamic> usersJson = response.data['data'];
        final List<UserModel> users = usersJson.map((json) => UserModel.fromJson(json)).toList();

        return UserResponse(users: users, total: response.data['total_pages'] ?? 0);
      } else {
        CommonFunctions.showWarningSnackBar(response.error?.toString() ?? "Unknown error");
        return UserResponse(users: [], total: 0);
      }
    } catch (e) {
      throw Exception(ApiService.handleError(e));
    }
  }
}
