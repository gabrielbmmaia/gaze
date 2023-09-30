import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gaze/features/series/domain/models/youtube_trailers_model.dart';
import 'package:gaze/features/series/domain/usecases/get_youtube_trailers.dart';

part 'yt_trailers_event.dart';

part 'yt_trailers_state.dart';

class YtTrailersBloc extends Bloc<YtTrailersEvent, YtTrailersState> {
  YtTrailersBloc({required GetYoutubeTrailersUseCase getYoutubeTrailers})
      : _getYoutubeTrailers = getYoutubeTrailers,
        super(const YtTrailersInitial()) {
    on<LoadYtTrailersEvent>(_youtubeTrailersHandler);
  }

  final GetYoutubeTrailersUseCase _getYoutubeTrailers;

  Future<void> _youtubeTrailersHandler(
    LoadYtTrailersEvent event,
    Emitter<YtTrailersState> emit,
  ) async {
    emit(const LoadingYtTrailers());
    final result = await _getYoutubeTrailers(event.seriesId);

    result.fold(
      (failure) => emit(const ErrorYtTrailers()),
      (data) => emit(LoadedYtTrailers(trailersList: data)),
    );
  }
}
