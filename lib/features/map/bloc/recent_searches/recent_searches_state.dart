part of 'recent_searches_bloc.dart';

sealed class RecentSearchesState extends Equatable {
  const RecentSearchesState();

  @override
  List<Object> get props => [];
}

final class RecentSearchesInitial extends RecentSearchesState {}

final class RecentSearchesLoading extends RecentSearchesState {}

final class RecentSearchesLoaded extends RecentSearchesState {
  final List<Location> locations;

  const RecentSearchesLoaded({required this.locations});
}

final class RecentSearchesError extends RecentSearchesState {}
