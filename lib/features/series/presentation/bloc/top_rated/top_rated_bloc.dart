import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gaze/features/series/domain/models/series_model.dart';
import 'package:gaze/features/series/domain/usecases/get_top_rated_series.dart';

part 'top_rated_event.dart';

part 'top_rated_state.dart';

class TopRatedBloc extends Bloc<TopRatedEvent, TopRatedState> {
  TopRatedBloc({required GetTopRatedSeriesUseCase getTopRatedSeries})
      : _getTopRatedSeries = getTopRatedSeries,
        super(const TopRatedInitial()) {
    on<LoadTopRatedListEvent>(_topRatedSeriesHandler);
  }

  final GetTopRatedSeriesUseCase _getTopRatedSeries;

  Future<void> _topRatedSeriesHandler(
    LoadTopRatedListEvent event,
    Emitter<TopRatedState> emit,
  ) async {
    emit(const LoadingTopRatedSeries());
    final result = await _getTopRatedSeries();

    result.fold(
      (failure) => emit(const ErrorTopRatedSeries()),
      (data) => emit(LoadedTopRatedSeries(topRatedList: data)),
    );
  }
}
