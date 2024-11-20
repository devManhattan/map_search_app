import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:test_konsi/features/favorites/repository/favorites_repository.dart';
import 'package:test_konsi/global/models/location.dart';

part 'list_favorites_event.dart';
part 'list_favorites_state.dart';

class ListFavoritesBloc extends Bloc<ListFavoritesEvent, ListFavoritesState> {
  FavoritesRepository favoriteRepository;
  ListFavoritesBloc(this.favoriteRepository) : super(ListFavoritesInitial()) {
    on<ExecuteListFavoritesEvent>(list);
    on<DeleteListFavoritesEvent>(delete);
  }
  Future<void> list(
    ExecuteListFavoritesEvent event,
    Emitter<ListFavoritesState> emit,
  ) async {
    emit(ListFavoritesLoading());
    final (Exception? error, List<Location>? locations) =
        await favoriteRepository.getLocations();
    if (error != null) {
      emit(ListFavoritesError());
      return;
    }
    emit(ListFavoritesLoaded(locations: locations!));
  }

  Future<void> delete(
    DeleteListFavoritesEvent event,
    Emitter<ListFavoritesState> emit,
  ) async {
    emit(ListFavoritesLoading());

    await favoriteRepository.delete(event.id);

    add(ExecuteListFavoritesEvent());
  }
}
