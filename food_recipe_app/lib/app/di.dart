import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:food_recipe_app/app/app_prefs.dart';
import 'package:food_recipe_app/data/background_data/device_info.dart';
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
import 'package:food_recipe_app/domain/usecase/facebook_login_usecase.dart';
import 'package:food_recipe_app/domain/usecase/get_chefs_from_rank_usecase.dart';
import 'package:food_recipe_app/domain/usecase/get_recipes_from_likes_usecase.dart';
import 'package:food_recipe_app/domain/usecase/get_saved_recipes_usecase.dart';
import 'package:food_recipe_app/domain/usecase/google_login_usecase.dart';
import 'package:food_recipe_app/domain/usecase/login_usecase.dart';
import 'package:food_recipe_app/domain/usecase/login_verify_usecase.dart';
import 'package:food_recipe_app/domain/usecase/refresh_access_token_usecase.dart';
import 'package:food_recipe_app/domain/usecase/signup_with_email_usecase.dart';
import 'package:food_recipe_app/domain/usecase/signup_with_loginId_usecase.dart';
import 'package:food_recipe_app/presentation/blocs/create_recipe/create_recipe_bloc.dart';
import 'package:food_recipe_app/presentation/blocs/login/login_bloc.dart';

import 'package:food_recipe_app/domain/usecase/get_recipes_by_category_usecase.dart';
import 'package:food_recipe_app/presentation/blocs/recipes_by_category/recipes_by_category_bloc.dart';
import 'package:food_recipe_app/presentation/blocs/saved_recipes/saved_recipes_bloc.dart';
import 'package:food_recipe_app/presentation/blocs/trending_recipes/trending_bloc.dart';
import 'package:food_recipe_app/presentation/blocs/verified_chefs/verified_chefs_bloc.dart';
import 'package:food_recipe_app/presentation/setting_kitchen/create_profile/bloc/create_profile_bloc.dart';
import 'package:food_recipe_app/presentation/setting_kitchen/food_type/bloc/food_type_bloc.dart';

import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../presentation/resources/route_management.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  final sharedPrefs = await SharedPreferences.getInstance();
  // shared prefs instance
  instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);
  // app prefs instance
  instance
      .registerLazySingleton<AppPreferences>(() => AppPreferences(instance()));
  instance.registerLazySingleton(() => InitialRoute(instance()));
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
  //Repository
  initRepository();

  //INITIALIZE INTERCEPTOR FOR REFRESH TOKEN
  if (!instance.isRegistered<RefreshAccessTokenUseCase>()) {
    instance.registerLazySingleton<RefreshAccessTokenUseCase>(
        () => RefreshAccessTokenUseCase(instance()));
  }
  instance<DioFactory>().initializeInterceptor(dio, instance());
}

void initRepository() {
  instance.registerLazySingleton<RecipeRepository>(
      () => RecipeRepositoryImpl(instance(), instance()));
  instance.registerLazySingleton<LoginRepository>(
      () => LoginRepositoryImpl(instance(), instance(), instance()));
  instance.registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(instance(), instance(), instance()));
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
  if (!instance.isRegistered<GetChefsFromRankUseCase>()) {
    instance.registerLazySingleton<GetChefsFromRankUseCase>(
        () => GetChefsFromRankUseCase(instance()));
  }
  if (!instance.isRegistered<RecipesByCategoryBloc>()) {
    instance.registerLazySingleton(() => RecipesByCategoryBloc(instance()));
  }
  if (!instance.isRegistered<TrendingBloc>()) {
    instance.registerLazySingleton(() => TrendingBloc(instance()));
  }
  if (!instance.isRegistered<VerifiedChefsBloc>()) {
    instance.registerLazySingleton(() => VerifiedChefsBloc(instance()));
  }
}

initSavedRecipeModule() {
  if (!instance.isRegistered<GetSavedRecipesUseCase>()) {
    instance.registerLazySingleton<GetSavedRecipesUseCase>(
        () => GetSavedRecipesUseCase(instance()));
  }
  if (!instance.isRegistered<SavedRecipesBloc>()) {
    instance.registerLazySingleton<SavedRecipesBloc>(
        () => SavedRecipesBloc(instance()));
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
  if (!instance.isRegistered<FacebookLoginUseCase>()) {
    instance.registerLazySingleton<FacebookLoginUseCase>(
        () => FacebookLoginUseCase(instance()));
  }

  if(!instance.isRegistered<GoogleSignIn>()){
    instance.registerLazySingleton(() => GoogleSignIn());
  }
  if(!instance.isRegistered<FacebookAuth>()){
    instance.registerLazySingleton(() => FacebookAuth.instance);
  }
  //register login bloc
  if (!instance.isRegistered<LoginBloc>()) {
    instance.registerLazySingleton(() => LoginBloc(
          googleSignIn: instance(),
          loginUseCase: instance(),
          facebookLoginUseCase: instance(),
          googleLoginUseCase: instance(),
          facebookAuth: instance(),
        ));
  }
}

initFoodTypeModule(){
  if(!instance.isRegistered<SignupWithEmailUseCase>()){
    instance.registerLazySingleton<SignupWithEmailUseCase>(() => SignupWithEmailUseCase(instance()));
  }
  if(!instance.isRegistered<SignupWithLoginIdUseCase>()){
    instance.registerLazySingleton<SignupWithLoginIdUseCase>(() => SignupWithLoginIdUseCase(instance()));
  }
  if (!instance.isRegistered<FoodTypeBloc>()) {
    instance.registerLazySingleton(
            () => FoodTypeBloc(signupWithLoginIdUseCase: instance(),signupUseCase: instance()));
  }
}
initCreateProfileModule(){
  if(!instance.isRegistered<LoginVerifyUseCase>()){
    instance.registerLazySingleton<LoginVerifyUseCase>(() => LoginVerifyUseCase(instance()));
  }
  if (!instance.isRegistered<CreateProfileBloc>()) {
    instance.registerLazySingleton(() => CreateProfileBloc(loginVerifyUseCase: instance()));
  }
}


initDeviceInfo(TargetPlatform targetPlatform) {
  debugPrint("initDeviceInfo");
  if (!instance.isRegistered<DeviceInfo>()) {
    instance.registerLazySingleton(
        () => DeviceInfo(targetPlatform: targetPlatform));
  }
}


