import 'package:codebase/core/network/api_client.dart';
import 'package:codebase/core/network/api_constants.dart';
import 'package:codebase/core/network/api_service.dart';
import 'package:codebase/core/utils/common_functions.dart';
import 'package:codebase/features/user_list/data/models/user_model.dart';

class UserRemoteDataSource {
  final ApiClient apiClient;

  UserRemoteDataSource(this.apiClient);

  Future<List<UserModel>> fetchUsers(int page, int perPage) async {
    try {
      final response = await apiClient.get(ApiConstants.users, params: {'per_page': perPage, 'page': page});
      if (response.data != null) {
        final List users = response.data['data'];
        return users.map((json) => UserModel.fromJson(json)).toList();
      } else {
        CommonFunctions.showWarningSnackBar(response.error.toString());
        return [];
      }
    } catch (e) {
      throw Exception(ApiService.handleError(e));
    }
  }
}
