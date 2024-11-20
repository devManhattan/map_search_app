part of 'list_favorites_bloc.dart';

sealed class ListFavoritesState extends Equatable {
  const ListFavoritesState();

  @override
  List<Object> get props => [];
}

final class ListFavoritesInitial extends ListFavoritesState {}

final class ListFavoritesLoading extends ListFavoritesState {}

final class ListFavoritesLoaded extends ListFavoritesState {
  final List<Location> locations;

  const ListFavoritesLoaded({required this.locations});
}

final class ListFavoritesError extends ListFavoritesState {}
