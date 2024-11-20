import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:test_konsi/global/models/location.dart';
import 'package:test_konsi/features/map/repository/map_repository.dart';

part 'save_favorite_event.dart';
part 'save_favorite_state.dart';

class SaveFavoriteBloc extends Bloc<SaveFavoriteEvent, SaveFavoriteState> {
  MapRepository mapRepository;
  SaveFavoriteBloc(
    this.mapRepository,
  ) : super(SaveFavoriteInitial()) {
    on<SaveFavoriteEvent>((event, emit) {
      if (event is ExecuteSaveFavoriteEvent) {
        try {
          emit(SaveFavoriteLoading());
          mapRepository.saveToFavorite(event.location);
          emit(SaveFavoriteLoaded());
        } catch (e) {
          emit(SaveFavoriteError());
        }
      }
    });
  }
}
