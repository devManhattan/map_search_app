import 'dart:convert';

import 'package:latlong2/latlong.dart';
import 'package:sqflite/sqflite.dart';
import 'package:test_konsi/core/endpoints.dart';
import 'package:test_konsi/global/models/location.dart';
import 'package:http/http.dart' as http;

abstract class MapDatasource {
  Future<Location> getLocation(String cep);
  Future<List<Location>> getRecents();
  Future<LatLng> getLocationLatLang(String address);
  Future<int> saveLocation(Location cep);
  Future<void> saveToFavorites(Location cep);
}

class MapDatasourceImpl implements MapDatasource {
  Database db;
  MapDatasourceImpl({required this.db});

  @override
  Future<Location> getLocation(String cep) async {
    String url = Endpoints.viaCepUrl.replaceAll('#CEP#', cep);

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      if (data['erro'] != null) {
        throw Exception(
          'CEP not found',
        );
      }
      return Location.fromJson(data);
    } else {
      throw Exception(
        'Erro interno',
      );
    }
  }

  @override
  Future<int> saveLocation(Location cep) async {
    return db.insert('location', cep.toJson());
  }

  @override
  Future<LatLng> getLocationLatLang(String address) async {
    String apikey = '';
    final response = await http.get(Uri.parse(Endpoints.mapsApi
        .replaceAll("#ADDRESS#", Uri.encodeComponent(address))
        .replaceAll("#KEY#", apikey)));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['results'].isNotEmpty) {
        final location = data['results'][0]['geometry']['location'];
        return LatLng(
          location['lat'],
          location['lng'],
        );
      } else {
        throw Exception('Endereço não encontrado');
      }
    } else {
      throw Exception('Erro ao consultar a API do Google Maps');
    }
  }

  @override
  Future<List<Location>> getRecents() async {
    List<Map<String, dynamic>> result =
        await db.rawQuery("SELECT * FROM location GROUP BY cep");

    return result.map((e) => Location.fromDb(e)).toList();
  }

  @override
  Future<void> saveToFavorites(Location cep) async {
    db.insert('history', {
      'locationid': cep.id,
      'cep': cep.cep,
      'logradouro': cep.logradouro,
      'complemento': cep.complemento,
      'numero': cep.numero
    });
  }
}
