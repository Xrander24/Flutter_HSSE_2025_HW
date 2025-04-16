import 'package:get_it/get_it.dart';
import 'package:hsse_cat_tinder/data/sources/cat_api_source.dart';
import 'package:hsse_cat_tinder/data/repositories/cat_repository_impl.dart';
import 'package:hsse_cat_tinder/domain/repositories/cat_repository.dart';
import 'package:hsse_cat_tinder/domain/usecases/get_cats.dart';
import 'package:hsse_cat_tinder/presentation/cubits/home_cubit.dart';
import 'package:hsse_cat_tinder/presentation/cubits/liked_cubit.dart';

final getIt = GetIt.instance;

void setupDI() {
  getIt.registerLazySingleton<CatApiSource>(() => CatApiSource());
  // Repository
  getIt.registerLazySingleton<CatRepository>(
    () => CatRepositoryImpl(getIt<CatApiSource>()),
  );

  // UseCases
  getIt.registerLazySingleton<GetCats>(() => GetCats(getIt<CatRepository>()));

  // Cubits
  getIt.registerFactory(() => HomeCubit(getIt<CatRepository>()));
  getIt.registerFactory(() => LikedCubit());
}
