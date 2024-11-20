part of 'save_favorite_bloc.dart';

sealed class SaveFavoriteState extends Equatable {
  const SaveFavoriteState();

  @override
  List<Object> get props => [];
}

final class SaveFavoriteInitial extends SaveFavoriteState {}

final class SaveFavoriteLoading extends SaveFavoriteState {}

final class SaveFavoriteLoaded extends SaveFavoriteState {}

final class SaveFavoriteError extends SaveFavoriteState {}
