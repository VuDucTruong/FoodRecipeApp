import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:food_recipe_app/app/app_prefs.dart';
import 'package:food_recipe_app/data/background_data/device_info.dart';
import 'package:food_recipe_app/data/data_source/login_remote_data_source.dart';
import 'package:food_recipe_app/data/data_source/recipe_remote_data_source.dart';
import 'package:food_recipe_app/data/data_source/user_remote_data_source.dart';
import 'package:food_recipe_app/data/network/dio_factory.dart';
import 'package:food_recipe_app/data/network/network_info.dart';
import 'package:food_recipe_app/data/respository_impl/login_repository.dart';
import 'package:food_recipe_app/data/respository_impl/recipe_respository.dart';
import 'package:food_recipe_app/data/respository_impl/user_repository.dart';
import 'package:food_recipe_app/domain/respository/login_repository.dart';
import 'package:food_recipe_app/domain/respository/recipe_respository.dart';
import 'package:food_recipe_app/domain/respository/user_repository.dart';
import 'package:food_recipe_app/domain/usecase/facebook_login_usecase.dart';
import 'package:food_recipe_app/domain/usecase/get_recipes_from_likes_usecase.dart';
import 'package:food_recipe_app/domain/usecase/get_user_info_usecase.dart';
import 'package:food_recipe_app/domain/usecase/google_login_usecase.dart';
import 'package:food_recipe_app/domain/usecase/login_usecase.dart';
import 'package:food_recipe_app/domain/usecase/refresh_access_token_usecase.dart';
import 'package:food_recipe_app/presentation/login/bloc/login_bloc.dart';
import 'package:food_recipe_app/presentation/main/home/bloc/home_bloc.dart';
import 'package:food_recipe_app/presentation/main/main_view_bloc/main_view_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  final sharedPrefs = await SharedPreferences.getInstance();
  // shared prefs instance
  instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);
  // app prefs instance
  instance
      .registerLazySingleton<AppPreferences>(() => AppPreferences(instance()));

  // network info
  instance.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(InternetConnectionChecker()));

  // dio factory
  instance.registerLazySingleton<DioFactory>(() => DioFactory(instance()));

  // app  service client
  final dio = await instance<DioFactory>().getDio();

  // remote data source
  instance
      .registerLazySingleton<RemoteDataSource>(() => RemoteDataSourceImpl(dio));
  instance.registerLazySingleton<LoginRemoteDataSource>(
      () => LoginRemoteDataSourceImpl(dio,instance()));
  instance.registerLazySingleton<UserRemoteDataSource>(
      () => UserRemoteDataSourceImpl(dio,instance()));

  instance.registerLazySingleton<RecipeRespository>(
      () => RecipeRespositoryImpl(instance(), instance()));
  instance.registerLazySingleton<LoginRepository>(
      () => LoginRepositoryImpl(instance(), instance(), instance()));
  instance.registerLazySingleton<UserRepository>(
          () => UserRepositoryImpl(instance(),instance(),instance()));

  initLoginModule();
  initMainModule();
  //INITIALIZE INTERCEPTOR FOR REFRESH TOKEN
  instance<DioFactory>().initializeInterceptor(dio, instance());
}

initMainModule(){
  instance.registerLazySingleton<GetUserInfoUseCase>(
      () => GetUserInfoUseCase(instance()));
  instance.registerLazySingleton
    (() => MainViewBloc( instance()));
}


initHomeModule() {
  // register necessary usecase in home page
  instance.registerLazySingleton<GetRecipesFromLikesUseCase>(
      () => GetRecipesFromLikesUseCase(instance()));
  // register home bloc
  instance.registerLazySingleton(
      () => HomeBloc(getRecipesFromLikesUseCase: instance()));
}

initLoginModule() {
  //register necessary usecase in login page
  debugPrint("initLoginmodule");
  if (!instance.isRegistered<LoginUseCase>()) {
    instance
        .registerLazySingleton<LoginUseCase>(() => LoginUseCase(instance()));
  }
  if(!instance.isRegistered<RefreshAccessTokenUseCase>())
    {
      instance.registerLazySingleton<RefreshAccessTokenUseCase>(() => RefreshAccessTokenUseCase(instance()));
    }
  if(!instance.isRegistered<GoogleLoginUseCase>())
    {
      instance.registerLazySingleton<GoogleLoginUseCase>(() => GoogleLoginUseCase(instance()));
    }
  if(!instance.isRegistered<FacebookLoginUseCase>())
    {
      instance.registerLazySingleton<FacebookLoginUseCase>(() => FacebookLoginUseCase(instance()));
    }

  instance.registerLazySingleton(() => GoogleSignIn());
  instance.registerLazySingleton(() => FacebookAuth.instance);
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

initDeviceInfo(TargetPlatform targetPlatform){
  debugPrint("initDeviceInfo");
  if(!instance.isRegistered<DeviceInfo>())
    {
      instance.registerLazySingleton(() => DeviceInfo(targetPlatform:targetPlatform));
    }
}
