part of 'save_favorite_bloc.dart';

sealed class SaveFavoriteEvent extends Equatable {
  const SaveFavoriteEvent();

  @override
  List<Object> get props => [];
}

class ExecuteSaveFavoriteEvent extends SaveFavoriteEvent {
  final Location location;

  const ExecuteSaveFavoriteEvent({required this.location});
  @override
  List<Object> get props => [];
}
