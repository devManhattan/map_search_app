part of 'list_favorites_bloc.dart';

sealed class ListFavoritesEvent extends Equatable {
  const ListFavoritesEvent();

  @override
  List<Object> get props => [];
}

class ExecuteListFavoritesEvent extends ListFavoritesEvent {
  @override
  List<Object> get props => [];
}

class DeleteListFavoritesEvent extends ListFavoritesEvent {
  final int id;
  const DeleteListFavoritesEvent({required this.id});
  @override
  List<Object> get props => [id];
}
