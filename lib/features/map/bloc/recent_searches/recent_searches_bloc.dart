import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:test_konsi/global/models/location.dart';
import 'package:test_konsi/features/map/repository/map_repository.dart';

part 'recent_searches_event.dart';
part 'recent_searches_state.dart';

class RecentSearchesBloc
    extends Bloc<RecentSearchesEvent, RecentSearchesState> {
  MapRepository mapRepository;
  RecentSearchesBloc(
    this.mapRepository,
  ) : super(RecentSearchesInitial()) {
    on<RecentSearchesEvent>((event, emit) async {
      emit(RecentSearchesLoading());
      if (event is GetRecentSearchesEvent) {
        final (Exception? error, List<Location>? recents) =
            await mapRepository.getRecents();
        if (error != null) {
          emit(RecentSearchesError());
          return;
        }
        emit(RecentSearchesLoaded(locations: recents!));
      }
    });
  }
}
