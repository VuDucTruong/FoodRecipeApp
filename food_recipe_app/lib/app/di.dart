import 'package:flutter/cupertino.dart';
import 'package:food_recipe_app/app/app_prefs.dart';
import 'package:food_recipe_app/data/data_source/notification_remote_datasource.dart';
import 'package:food_recipe_app/domain/repository/notification_repository.dart';
import 'package:food_recipe_app/domain/usecase/delete_notification_usecase.dart';
import 'package:food_recipe_app/domain/usecase/get_chefs_by_ids_usecase.dart';
import 'package:food_recipe_app/domain/usecase/get_user_notification_usecase.dart';
import 'package:food_recipe_app/domain/usecase/update_is_read_by_offset_usecase.dart';
import 'package:food_recipe_app/presentation/blocs/ai_recipe/ai_recipe_bloc.dart';
import 'package:food_recipe_app/presentation/blocs/user_notification/user_notification_bloc.dart';
import 'package:food_recipe_app/presentation/utils/background_data_manager.dart';
import 'package:food_recipe_app/presentation/utils/device_info.dart';
import 'package:food_recipe_app/data/data_source/login_remote_data_source.dart';
import 'package:food_recipe_app/data/data_source/recipe_remote_data_source.dart';
import 'package:food_recipe_app/data/data_source/user_remote_data_source.dart';
import 'package:food_recipe_app/data/network/dio_factory.dart';
import 'package:food_recipe_app/data/network/network_info.dart';
import 'package:food_recipe_app/data/repository_impl/login_repository.dart';
import 'package:food_recipe_app/data/repository_impl/recipe_respository.dart';
import 'package:food_recipe_app/data/repository_impl/user_repository.dart';
import 'package:food_recipe_app/domain/repository/login_repository.dart';
import 'package:food_recipe_app/domain/repository/recipe_respository.dart';
import 'package:food_recipe_app/domain/repository/user_repository.dart';
import 'package:food_recipe_app/domain/usecase/create_recipe_usecase.dart';
import 'package:food_recipe_app/domain/usecase/delete_user_profile_usecase.dart';
import 'package:food_recipe_app/domain/usecase/delete_user_recipe_usecase.dart';
import 'package:food_recipe_app/domain/usecase/get_chef_info_by_id_usecase.dart';
import 'package:food_recipe_app/domain/usecase/get_chefs_from_rank_usecase.dart';
import 'package:food_recipe_app/domain/usecase/get_my_recipes_usecase.dart';
import 'package:food_recipe_app/domain/usecase/get_recipes_from_ids_usecase.dart';
import 'package:food_recipe_app/domain/usecase/get_recipes_from_likes_usecase.dart';
import 'package:food_recipe_app/domain/usecase/get_saved_recipes_usecase.dart';
import 'package:food_recipe_app/domain/usecase/get_search_chefs_usecase.dart';
import 'package:food_recipe_app/domain/usecase/get_user_info_usecase.dart';
import 'package:food_recipe_app/domain/usecase/google_login_usecase.dart';
import 'package:food_recipe_app/domain/usecase/login_usecase.dart';
import 'package:food_recipe_app/domain/usecase/login_verify_usecase.dart';
import 'package:food_recipe_app/domain/usecase/refresh_access_token_usecase.dart';
import 'package:food_recipe_app/domain/usecase/update_like_recipe_usecase.dart';
import 'package:food_recipe_app/domain/usecase/update_password_usecase.dart';
import 'package:food_recipe_app/domain/usecase/update_saved_recipe_usecase.dart';
import 'package:food_recipe_app/domain/usecase/update_user_follow_usecase.dart';
import 'package:food_recipe_app/domain/usecase/update_user_profile_usecase.dart';

import 'package:food_recipe_app/presentation/blocs/chef_info/chef_info_bloc.dart';

import 'package:food_recipe_app/domain/usecase/signup_with_email_usecase.dart';
import 'package:food_recipe_app/domain/usecase/signup_with_loginId_usecase.dart';

import 'package:food_recipe_app/presentation/blocs/create_recipe/create_recipe_bloc.dart';
import 'package:food_recipe_app/presentation/blocs/login/login_bloc.dart';

import 'package:food_recipe_app/domain/usecase/get_recipes_by_category_usecase.dart';
import 'package:food_recipe_app/presentation/blocs/recipes_by_category/recipes_by_category_bloc.dart';
import 'package:food_recipe_app/presentation/blocs/saved_recipes/saved_recipes_bloc.dart';
import 'package:food_recipe_app/presentation/blocs/trending_recipes/trending_bloc.dart';
import 'package:food_recipe_app/presentation/blocs/user_profile/user_profile_bloc.dart';
import 'package:food_recipe_app/presentation/blocs/user_recipes/user_recipes_bloc.dart';
import 'package:food_recipe_app/presentation/blocs/verified_chefs/verified_chefs_bloc.dart';
import 'package:food_recipe_app/presentation/change_password/bloc/change_password_bloc.dart';
import 'package:food_recipe_app/presentation/detail_recipe/bloc/detail_recipe_bloc.dart';
import 'package:food_recipe_app/presentation/edit_profile/bloc/edit_profile_bloc.dart';
import 'package:food_recipe_app/presentation/setting_kitchen/create_profile/bloc/create_profile_bloc.dart';
import 'package:food_recipe_app/presentation/setting_kitchen/food_type/bloc/food_type_bloc.dart';
import 'package:food_recipe_app/presentation/utils/notification_helper.dart';

import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/repository_impl/notification_repository_impl.dart';
import '../presentation/resources/route_management.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  final sharedPrefs = await SharedPreferences.getInstance();
  // shared prefs instance
  instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);
  //register background data manager
  instance.registerLazySingleton<BackgroundDataManager>(
      () => BackgroundDataManager());

  // app prefs instance
  instance
      .registerLazySingleton<AppPreferences>(() => AppPreferences(instance()));
// Local notification
  instance.registerLazySingleton<NotificationHelper>(
      () => NotificationHelper(instance()));
  await instance<NotificationHelper>().setUpLocalNotification();
  // network info
  instance.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(InternetConnectionChecker()));

  // dio factory
  instance.registerLazySingleton<DioFactory>(() => DioFactory(instance()));

  // app  service client
  final dio = await instance<DioFactory>().getDio();
  // remote data source
  instance.registerLazySingleton<LoginRemoteDataSource>(
      () => LoginRemoteDataSourceImpl(dio, instance()));
  instance.registerLazySingleton<UserRemoteDataSource>(
      () => UserRemoteDataSourceImpl(dio, instance()));
  instance.registerLazySingleton<RecipeRemoteDataSource>(
      () => RecipeRemoteDataSourceImpl(dio));
  instance.registerLazySingleton<NotificationRemoteDataSource>(
      () => NotificationRemoteDataSourceImpl(dio));
  //Repository
  initRepository();

  //INITIALIZE INTERCEPTOR FOR REFRESH TOKEN
  if (!instance.isRegistered<RefreshAccessTokenUseCase>()) {
    instance.registerLazySingleton<RefreshAccessTokenUseCase>(
        () => RefreshAccessTokenUseCase(instance()));
  }
  if (!instance.isRegistered<GetUserInfoUseCase>()) {
    instance.registerLazySingleton<GetUserInfoUseCase>(
        () => GetUserInfoUseCase(instance()));
  }
  if (!instance.isRegistered<InitialRoute>()) {
    instance.registerLazySingleton(() => InitialRoute(instance(), instance()));
  }
  instance<DioFactory>().initializeInterceptor(dio, instance());
}

void initRepository() {
  instance.registerLazySingleton<RecipeRepository>(() =>
      RecipeRepositoryImpl(instance(), instance(), instance(), instance()));
  instance.registerLazySingleton<LoginRepository>(
      () => LoginRepositoryImpl(instance(), instance(), instance()));
  instance.registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(instance(), instance(), instance(), instance()));
  instance.registerLazySingleton<NotificationRepository>(
      () => NotificationRepositoryImpl(instance(), instance()));
}

initHomeModule() {
  // register necessary usecase in home page
  if (!instance.isRegistered<GetRecipesFromLikesUseCase>()) {
    instance.registerLazySingleton<GetRecipesFromLikesUseCase>(
        () => GetRecipesFromLikesUseCase(instance()));
  }
  if (!instance.isRegistered<GetRecipesByCategoryUseCase>()) {
    instance.registerLazySingleton<GetRecipesByCategoryUseCase>(
        () => GetRecipesByCategoryUseCase(instance()));
  }
  if (!instance.isRegistered<GetRecipesFromIdsUseCase>()) {
    instance.registerLazySingleton<GetRecipesFromIdsUseCase>(
        () => GetRecipesFromIdsUseCase(instance()));
  }
  if (!instance.isRegistered<GetSearchChefsUseCase>()) {
    instance.registerLazySingleton<GetSearchChefsUseCase>(
        () => GetSearchChefsUseCase(instance()));
  }
  if (!instance.isRegistered<UpdateUserFollowUseCase>()) {
    instance.registerLazySingleton<UpdateUserFollowUseCase>(
        () => UpdateUserFollowUseCase(instance()));
  }
  if (!instance.isRegistered<RecipesByCategoryBloc>()) {
    instance.registerLazySingleton(() => RecipesByCategoryBloc(instance()));
  }
  if (!instance.isRegistered<TrendingBloc>()) {
    instance.registerLazySingleton(() => TrendingBloc(instance()));
  }
  if (!instance.isRegistered<GetChefsByIdsUseCase>()) {
    instance.registerLazySingleton(() => GetChefsByIdsUseCase(instance()));
  }
  if (!instance.isRegistered<VerifiedChefsBloc>()) {
    instance.registerLazySingleton(
        () => VerifiedChefsBloc(instance(), instance(), instance()));
  }
  if (!instance.isRegistered<UserRecipesBloc>()) {
    instance.registerLazySingleton<UserRecipesBloc>(
        () => UserRecipesBloc(instance()));
  }
}

initSavedRecipeModule() {
  if (!instance.isRegistered<GetSavedRecipesUseCase>()) {
    instance.registerLazySingleton<GetSavedRecipesUseCase>(
        () => GetSavedRecipesUseCase(instance()));
  }
  if (!instance.isRegistered<UpdateSavedRecipeUseCase>()) {
    instance.registerLazySingleton(
      () => UpdateSavedRecipeUseCase(instance()),
    );
  }
  if (!instance.isRegistered<GetMyRecipesUseCase>()) {
    instance.registerLazySingleton(
      () => GetMyRecipesUseCase(instance()),
    );
  }
  if (!instance.isRegistered<DeleteUserRecipeUseCase>()) {
    instance.registerLazySingleton(
      () => DeleteUserRecipeUseCase(instance()),
    );
  }
  if (!instance.isRegistered<SavedRecipesBloc>()) {
    instance.registerLazySingleton<SavedRecipesBloc>(
        () => SavedRecipesBloc(instance(), instance(), instance(), instance()));
  }
}

initCreateRecipeModule() {
  if (!instance.isRegistered<CreateRecipeBloc>()) {
    instance.registerLazySingleton<CreateRecipeBloc>(
        () => CreateRecipeBloc(instance()));
  }
  if (!instance.isRegistered<CreateRecipeUseCase>()) {
    instance.registerLazySingleton<CreateRecipeUseCase>(
        () => CreateRecipeUseCase(instance()));
  }
}

initLoginModule() {
  //register necessary usecase in login page
  if (!instance.isRegistered<LoginUseCase>()) {
    instance
        .registerLazySingleton<LoginUseCase>(() => LoginUseCase(instance()));
  }
  if (!instance.isRegistered<GoogleLoginUseCase>()) {
    instance.registerLazySingleton<GoogleLoginUseCase>(
        () => GoogleLoginUseCase(instance()));
  }
  if (!instance.isRegistered<GoogleSignIn>()) {
    instance.registerLazySingleton(() => GoogleSignIn());
  }
  //register login bloc
  if (!instance.isRegistered<LoginBloc>()) {
    instance.registerLazySingleton(() => LoginBloc(
          backgroundDataManager: instance(),
          googleSignIn: instance(),
          loginUseCase: instance(),
          googleLoginUseCase: instance(),
          networkInfo: instance(),
        ));
  }
}

initDetailFoodModule() {
  initChefProfileModule();
  if (!instance.isRegistered<UpdateSavedRecipeUseCase>()) {
    instance.registerLazySingleton<UpdateSavedRecipeUseCase>(
      () => UpdateSavedRecipeUseCase(instance()),
    );
  }
  if (!instance.isRegistered<UpdateLikeRecipeUseCase>()) {
    instance.registerLazySingleton<UpdateLikeRecipeUseCase>(
      () => UpdateLikeRecipeUseCase(instance()),
    );
  }
  if (!instance.isRegistered<DetailRecipeBloc>()) {
    instance.registerLazySingleton<DetailRecipeBloc>(
      () => DetailRecipeBloc(instance(), instance()),
    );
  }
}

initCreateProfileModule() {
  if (!instance.isRegistered<LoginVerifyUseCase>()) {
    instance.registerLazySingleton<LoginVerifyUseCase>(
        () => LoginVerifyUseCase(instance()));
  }
  if (!instance.isRegistered<CreateProfileBloc>()) {
    instance.registerLazySingleton<CreateProfileBloc>(
        () => CreateProfileBloc(loginVerifyUseCase: instance()));
  }
}

initFoodTypeModule() {
  if (!instance.isRegistered<SignupWithEmailUseCase>()) {
    instance.registerLazySingleton<SignupWithEmailUseCase>(
        () => SignupWithEmailUseCase(instance()));
  }
  if (!instance.isRegistered<SignupWithLoginIdUseCase>()) {
    instance.registerLazySingleton<SignupWithLoginIdUseCase>(
        () => SignupWithLoginIdUseCase(instance()));
  }
  if (!instance.isRegistered<FoodTypeBloc>()) {
    instance.registerLazySingleton(() => FoodTypeBloc(
          networkInfo: instance(),
          signupWithEmailUseCase: instance(),
          signupWithLoginIdUseCase: instance(),
        ));
  }
}

initChefProfileModule() {
  if (!instance.isRegistered<GetChefInfoByIdUseCase>()) {
    instance.registerLazySingleton<GetChefInfoByIdUseCase>(
        () => GetChefInfoByIdUseCase(instance()));
  }
  if (!instance.isRegistered<GetRecipesFromIdsUseCase>()) {
    instance.registerLazySingleton<GetRecipesFromIdsUseCase>(
        () => GetRecipesFromIdsUseCase(instance()));
  }
  if (!instance.isRegistered<ChefInfoBloc>()) {
    instance.registerLazySingleton<ChefInfoBloc>(
        () => ChefInfoBloc(instance(), instance(), instance()));
  }
}

initDeviceInfo(TargetPlatform targetPlatform) {
  debugPrint("initDeviceInfo");
  if (!instance.isRegistered<DeviceInfo>()) {
    instance.registerLazySingleton(
        () => DeviceInfo(targetPlatform: targetPlatform));
  }
}

initUserProfileModule() {
  if (!instance.isRegistered<UpdatePasswordUseCase>()) {
    instance.registerLazySingleton<UpdatePasswordUseCase>(
      () => UpdatePasswordUseCase(instance()),
    );
  }
  if (!instance.isRegistered<UserProfileBloc>()) {
    instance.registerLazySingleton(
      () => UserProfileBloc(instance()),
    );
  }
  if (!instance.isRegistered<GetUserNotificationUseCase>()) {
    instance.registerLazySingleton(
      () => GetUserNotificationUseCase(instance()),
    );
  }
  if (!instance.isRegistered<DeleteNotificationUseCase>()) {
    instance.registerLazySingleton(
      () => DeleteNotificationUseCase(instance()),
    );
  }
  if (!instance.isRegistered<UpdateIsReadByOffsetUseCase>()) {
    instance.registerLazySingleton(
      () => UpdateIsReadByOffsetUseCase(instance()),
    );
  }
  if (!instance.isRegistered<UserNotificationBloc>()) {
    instance.registerLazySingleton(
      () => UserNotificationBloc(instance(), instance(), instance()),
    );
  }
  initEditProfileModule();
}

initEditProfileModule() {
  if (!instance.isRegistered<UpdatePasswordUseCase>()) {
    instance.registerLazySingleton<UpdatePasswordUseCase>(
      () => UpdatePasswordUseCase(instance()),
    );
  }
  if (!instance.isRegistered<UpdateUserProfileUseCase>()) {
    instance.registerLazySingleton<UpdateUserProfileUseCase>(
      () => UpdateUserProfileUseCase(instance()),
    );
  }

  if (!instance.isRegistered<DeleteUserProfileUseCase>()) {
    instance.registerLazySingleton<DeleteUserProfileUseCase>(
      () => DeleteUserProfileUseCase(instance()),
    );
  }
  if (!instance.isRegistered<EditProfileBloc>()) {
    instance.registerLazySingleton(
      () => EditProfileBloc(
          backgroundDataManager: instance(),
          updateUserProfileUseCase: instance(),
          deleteUserProfileUseCase: instance()),
    );
  }
}

initAIRecipeModule() {
  if (!instance.isRegistered<AIRecipeBloc>()) {
    instance.registerLazySingleton(
      () => AIRecipeBloc(),
    );
  }
}

void initChangePasswordModule() {
  if (!instance.isRegistered<ChangePasswordBloc>()) {
    instance.registerLazySingleton(
      () => ChangePasswordBloc(
        instance(),
      ),
    );
  }
}
