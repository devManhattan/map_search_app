part of 'map_bloc.dart';

sealed class MapState extends Equatable {
  const MapState();

  @override
  List<Object> get props => [];
}

final class MapInitial extends MapState {}

final class MapLoading extends MapState {}

final class MapLoaded extends MapState {
  final LatLng latLng;
  final Location location;

  const MapLoaded( {required this.location, required this.latLng});
}

final class MapError extends MapState {}
