import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gaze/features/series/domain/models/series_model.dart';
import 'package:gaze/features/series/domain/usecases/get_trending_series.dart';

part 'trending_event.dart';

part 'trending_state.dart';

class TrendingBloc extends Bloc<TrendingEvent, TrendingState> {
  TrendingBloc({required GetTrendingSeriesUseCase getTrendingSeries})
      : _getTrendingSeries = getTrendingSeries,
        super(const TrendingInitial()) {
    on<LoadTrendingListEvent>(_trendingSeriesHandler);
  }

  final GetTrendingSeriesUseCase _getTrendingSeries;

  Future<void> _trendingSeriesHandler(
    LoadTrendingListEvent event,
    Emitter<TrendingState> emit,
  ) async {
    emit(const LoadingTrendingSeries());

    final result = await _getTrendingSeries();

    result.fold(
      (failure) => emit(const ErrorTrendingSeries()),
      (data) => emit(LoadedTrendingSeries(trendingList: data)),
    );
  }
}
