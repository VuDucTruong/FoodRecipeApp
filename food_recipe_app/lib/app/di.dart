import 'package:food_recipe_app/app/app_prefs.dart';
import 'package:food_recipe_app/data/data_source/recipe_remote_data_source.dart';
import 'package:food_recipe_app/data/network/dio_factory.dart';
import 'package:food_recipe_app/data/network/network_info.dart';
import 'package:food_recipe_app/data/respository_impl/recipe_respository.dart';
import 'package:food_recipe_app/domain/respository/recipe_respository.dart';
import 'package:food_recipe_app/domain/usecase/get_recipes_by_category.dart';
import 'package:food_recipe_app/domain/usecase/get_recipes_from_likes_usecase.dart';
import 'package:food_recipe_app/presentation/blocs/recipes_by_category/recipes_by_category_bloc.dart';
import 'package:food_recipe_app/presentation/blocs/trending_recipes/trending_bloc.dart';
import 'package:get_it/get_it.dart';
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
  instance.registerLazySingleton<RecipeRemoteDataSource>(
      () => RecipeRemoteDataSourceImpl(dio));

  instance.registerLazySingleton<RecipeRespository>(
      () => RecipeRespositoryImpl(instance(), instance()));
}

initHomeModule() {
  // register necessary usecase in home page
  if (!instance.isRegistered<GetRecipesFromLikesUseCase>()) {
    instance.registerLazySingleton<GetRecipesFromLikesUseCase>(
        () => GetRecipesFromLikesUseCase(instance()));
  }
  if (!instance.isRegistered<GetRecipesByCategory>()) {
    instance.registerLazySingleton<GetRecipesByCategory>(
        () => GetRecipesByCategory(instance()));
  }
  if (!instance.isRegistered<RecipesByCategoryBloc>()) {
    instance.registerLazySingleton(() => RecipesByCategoryBloc(instance()));
  }
  if (!instance.isRegistered<TrendingBloc>()) {
    instance.registerLazySingleton(() => TrendingBloc(instance()));
  }
}
