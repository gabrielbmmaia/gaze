import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gaze/features/series/domain/models/series_model.dart';
import 'package:gaze/features/series/domain/usecases/get_series_by_genre.dart';

part 'genre_event.dart';

part 'genre_state.dart';

class GenreBloc extends Bloc<GenreEvent, GenreState> {
  GenreBloc({required GetSeriesByGenreUseCase getSeriesByGenre})
      : _getSeriesByGender = getSeriesByGenre,
        super(const GenreInitial()) {
    on<LoadGenreListEvent>(_genreListHandler);
  }

  final GetSeriesByGenreUseCase _getSeriesByGender;

  Future<void> _genreListHandler(
    LoadGenreListEvent event,
    Emitter<GenreState> emit,
  ) async {
    emit(const LoadingGenreList());
    final result = await _getSeriesByGender(event.genreId);

    result.fold(
      (failure) => emit(const ErrorGenreList()),
      (data) => emit(LoadedGenreList(genreList: data)),
    );
  }
}
