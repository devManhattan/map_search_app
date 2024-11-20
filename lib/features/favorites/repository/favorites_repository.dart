import 'package:test_konsi/features/favorites/datasources/favorites_datasource.dart';
import 'package:test_konsi/global/models/location.dart';

abstract class FavoritesRepository {
  Future<(Exception?, List<Location>?)> getLocations();
  Future<void> delete(int id);
}

class FavoritesRepositoryImpl implements FavoritesRepository {
  FavoritesDatasource favoritesDatasource;
  FavoritesRepositoryImpl({required this.favoritesDatasource});

  @override
  Future<void> delete(int id) async {
    try {
      await favoritesDatasource.delete(id);
      return;
    } catch (e) {
      return;
    }
  }

  @override
  Future<(Exception?, List<Location>?)> getLocations() async {
    try {
      List<Location> locations = await favoritesDatasource.getLocations();
      return (null, locations);
    } catch (e) {
      return (Exception(e.toString()), null);
    }
  }
}
