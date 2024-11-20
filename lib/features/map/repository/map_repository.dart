import 'package:latlong2/latlong.dart';
import 'package:test_konsi/features/map/datasource/map_datasource.dart';
import 'package:test_konsi/global/models/location.dart';

abstract class MapRepository {
  Future<(Exception?, Location?)> getLocation(String cep);
  Future<(Exception?, List<Location>?)> getRecents();
  Future<(Exception?, LatLng?)> getLocationLatLang(String address);
  Future<(Exception?, int?)> saveLocation(Location cep);
  Future<(Exception?, void)> saveToFavorite(Location cep);
}

class MapRepositoryImpl implements MapRepository {
  MapDatasource mapDatasource;
  MapRepositoryImpl({required this.mapDatasource});

  @override
  Future<(Exception?, int?)> saveLocation(Location cep) async {
    try {
      int result = await mapDatasource.saveLocation(cep);
      return (null, result);
    } catch (e, stackTrace) {
      return (Exception(stackTrace.toString()), null);
    }
  }

  @override
  Future<(Exception?, Location?)> getLocation(String cep) async {
    try {
      Location location = await mapDatasource.getLocation(cep);
      return (null, location);
    } catch (e, stackTrace) {
      return (Exception(stackTrace.toString()), null);
    }
  }

  @override
  Future<(Exception?, LatLng?)> getLocationLatLang(String address) async {
    try {
      LatLng latlng = await mapDatasource.getLocationLatLang(address);
      return (null, latlng);
    } catch (e) {
      return (e as Exception, null);
    }
  }

  @override
  Future<(Exception?, List<Location>?)> getRecents() async {
    try {
      List<Location> recents = await mapDatasource.getRecents();
      return (null, recents);
    } catch (e) {
      return (e as Exception, null);
    }
  }

  @override
  Future<(Exception?, void)> saveToFavorite(Location cep) async {
    try {
      await mapDatasource.saveToFavorites(cep);
      return (null, null);
    } catch (e) {
      return (e as Exception, null);
    }
  }
}
