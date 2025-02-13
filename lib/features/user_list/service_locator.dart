import 'package:codebase/core/network/api_client.dart';
import 'package:codebase/features/user_list/data/data_sources/user_remote_data_source.dart';
import 'package:codebase/features/user_list/data/repositories/user_repository.dart';
import 'package:codebase/features/user_list/domain/use_cases/get_users.dart';
import 'package:codebase/features/user_list/presentation/bloc/user_bloc.dart';
import 'package:get_it/get_it.dart';


final slUser = GetIt.instance; // Service Locator instance

void setupUserLocator() async{
  //Ensure the API client is registered first
  if (!slUser.isRegistered<ApiClient>()) {
    slUser.registerLazySingletonAsync<ApiClient>(() => ApiClient.create());
  }

  //Wait for ApiClient to be initialized
  await slUser.isReady<ApiClient>();

  //Register Data Source
  slUser.registerLazySingleton<UserRemoteDataSource>(() => UserRemoteDataSource(slUser<ApiClient>()));

  //Register Repository
  slUser.registerLazySingleton<UserRepository>(() => UserRepository(slUser<UserRemoteDataSource>()));

  //Register Use Case
  slUser.registerLazySingleton<GetUsers>(() => GetUsers(slUser<UserRepository>()));

  //Register Bloc
  slUser.registerFactory<UserBloc>(() => UserBloc(slUser<GetUsers>()));
}