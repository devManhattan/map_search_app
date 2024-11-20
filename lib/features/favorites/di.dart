import 'package:get_it/get_it.dart';
import 'package:test_konsi/core/injector.dart';
import 'package:test_konsi/database/database.dart';
import 'package:test_konsi/features/favorites/bloc/list_favorites/list_favorites_bloc.dart';
import 'package:test_konsi/features/favorites/datasources/favorites_datasource.dart';
import 'package:test_konsi/features/favorites/repository/favorites_repository.dart';


class FavoritesInjector extends Injector {
  Future<void> _datasource(GetIt instance) async {
    final db = await DatabaseHelper().datebase;

    instance.registerLazySingleton<FavoritesDatasource>(
      () => FavoritesDatasourceImpl(database: db),
    );
  }

  Future<void> _repository(GetIt instance) async {
    instance.registerLazySingleton<FavoritesRepository>(
      () => FavoritesRepositoryImpl(
        favoritesDatasource: instance.get<FavoritesDatasource>(),
      ),
    );
  }

  Future<void> _bloc(GetIt instance) async {
    instance.registerLazySingleton<ListFavoritesBloc>(
      () => ListFavoritesBloc(
        instance.get<FavoritesRepository>(),
      ),
    );
  }

  @override
  Future<void> inject() async {
    await _datasource(i);
    await _repository(i);
    await _bloc(i);
  }
}
