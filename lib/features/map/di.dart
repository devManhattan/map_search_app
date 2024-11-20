import 'package:get_it/get_it.dart';
import 'package:test_konsi/core/injector.dart';
import 'package:test_konsi/database/database.dart';
import 'package:test_konsi/features/map/bloc/map/map_bloc.dart';
import 'package:test_konsi/features/map/bloc/recent_searches/recent_searches_bloc.dart';
import 'package:test_konsi/features/map/bloc/save_favorite/bloc/save_favorite_bloc.dart';
import 'package:test_konsi/features/map/datasource/map_datasource.dart';
import 'package:test_konsi/features/map/repository/map_repository.dart';

class MapInjector extends Injector {
  Future<void> _datasource(GetIt instance) async {
    final db = await DatabaseHelper().datebase;

    instance.registerLazySingleton<MapDatasource>(
      () => MapDatasourceImpl(db: db),
    );
  }

  Future<void> _repository(GetIt instance) async {
    instance.registerLazySingleton<MapRepository>(
      () => MapRepositoryImpl(
        mapDatasource: instance.get<MapDatasource>(),
      ),
    );
  }

  Future<void> _bloc(GetIt instance) async {
    instance.registerLazySingleton<MapBloc>(
      () => MapBloc(
        instance.get<MapRepository>(),
      ),
    );
     instance.registerLazySingleton<SaveFavoriteBloc>(
      () => SaveFavoriteBloc(
        instance.get<MapRepository>(),
      ),
    );
    instance.registerLazySingleton<RecentSearchesBloc>(
      () => RecentSearchesBloc(
        instance.get<MapRepository>(),
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
