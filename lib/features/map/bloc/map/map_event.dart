part of 'map_bloc.dart';

sealed class MapEvent extends Equatable {
  const MapEvent();

  @override
  List<Object> get props => [];
}


 class MapSearchEvent extends MapEvent {
  final String cep;

  const MapSearchEvent({required this.cep});

  @override
  List<Object> get props => [];
}
