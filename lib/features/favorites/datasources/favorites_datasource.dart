import 'package:sqflite/sqflite.dart';
import 'package:test_konsi/global/models/location.dart';

abstract class FavoritesDatasource {
  Future<List<Location>> getLocations();
  Future<void> delete(int id);
}

class FavoritesDatasourceImpl implements FavoritesDatasource {
  FavoritesDatasourceImpl({required this.database});
  final Database database;
  @override
  Future<void> delete(int id) async{
    database.delete('history', where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<List<Location>> getLocations() async {
    List<Map<String, dynamic>> result = await database.rawQuery("""
    select H.id, H.cep, H.logradouro, H.complemento, H.numero, L.localidade, L.uf, L.estado, L.bairro from
     location as L inner join history as H on L.id = H.locationid""");
    return result.map((e) => Location.fromDb(e)).toList();
  }
}
