import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gaze/core/enums/genres.dart';
import 'package:gaze/core/enums/networks.dart';
import 'package:gaze/features/series/domain/models/series_model.dart';
import 'package:gaze/features/series/domain/usecases/get_network_series.dart';
import 'package:gaze/features/series/domain/usecases/get_searched_series.dart';
import 'package:gaze/features/series/domain/usecases/get_series_by_genre.dart';
import 'package:gaze/features/series/presentation/enum/search_type.dart';

part 'series_list_event.dart';

part 'series_list_state.dart';

class SeriesListBloc extends Bloc<SeriesListEvent, SeriesListState> {
  SeriesListBloc({
    required GetSearchedSeriesUseCase getSearchedSeries,
    required GetSeriesByGenreUseCase getSeriesByGenre,
    required GetNetworkSeriesUseCase getNetworkSeries,
  })  : _getSeriesByGenre = getSeriesByGenre,
        _getSearchedSeries = getSearchedSeries,
        _getNetworkSeriesUseCase = getNetworkSeries,
        super(const SeriesListInitial()) {
    on<LoadSeriesListEvent>(_seriesListHandler);
  }

  final GetSearchedSeriesUseCase _getSearchedSeries;
  final GetSeriesByGenreUseCase _getSeriesByGenre;
  final GetNetworkSeriesUseCase _getNetworkSeriesUseCase;

  Future<void> _seriesListHandler(
    LoadSeriesListEvent event,
    Emitter<SeriesListState> emit,
  ) async {
    emit(const LoadingSeriesList());

    if (event.searchType == SearchType.network) {
      final result = await _getNetworkSeriesUseCase(event.network!);

      result.fold(
        (failure) => emit(const ErrorSeriesList()),
        (data) => emit(LoadedSeriesList(seriesList: data)),
      );
    }

    if (event.searchType == SearchType.genre) {
      final result = await _getSeriesByGenre(event.genre!);

      result.fold(
        (failure) => emit(const ErrorSeriesList()),
        (data) => emit(LoadedSeriesList(seriesList: data)),
      );
    }

    if (event.searchType == SearchType.text) {
      final result = await _getSearchedSeries(event.text!);

      result.fold(
        (failure) => emit(const ErrorSeriesList()),
        (data) => emit(LoadedSeriesList(seriesList: data)),
      );
    }
  }
}
