import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';
import 'package:test_konsi/global/models/location.dart';
import 'package:test_konsi/features/map/repository/map_repository.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapRepository mapRepository;
  MapBloc(
    this.mapRepository,
  ) : super(MapInitial()) {
    on<MapSearchEvent>(_search);
  }
  Future<void> _search(
    MapSearchEvent event,
    Emitter<MapState> emit,
  ) async {
    emit(MapLoading());
    final (Exception? erro, Location? location) =
        await mapRepository.getLocation(event.cep);
    if (erro != null) {
      emit(MapError());
      return;
    }
    final (
      Exception? latlangErro,
      LatLng? latlng
    ) = await mapRepository.getLocationLatLang(
        "${location!.logradouro} ${location.bairro} ${location.localidade} ${location.uf}");
    if (latlangErro != null) {
      emit(MapError());
      return;
    }
    final (Exception? onSaveError, int? id) =
        await mapRepository.saveLocation(location);
    if (onSaveError != null) {
      emit(MapError());
      return;
    }
    emit(MapLoaded(
        latLng: latlng!,
        location: Location.fromJson(location.toJson()..['id'] = id)));
  }
}
