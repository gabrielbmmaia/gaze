import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gaze/features/series/domain/models/series_model.dart';
import 'package:gaze/features/series/domain/usecases/get_searched_series.dart';

part 'searched_event.dart';

part 'searched_state.dart';

class SearchedBloc extends Bloc<SearchedEvent, SearchedState> {
  SearchedBloc({required GetSearchedSeriesUseCase getSearchedSeries})
      : _getSearchedSeries = getSearchedSeries,
        super(const SearchedInitial()) {
    on<LoadSearchedListEvent>(_searchedSeriesHandler);
  }

  final GetSearchedSeriesUseCase _getSearchedSeries;

  Future<void> _searchedSeriesHandler(
    LoadSearchedListEvent event,
    Emitter<SearchedState> emit,
  ) async {
    emit(const LoadingSearchedSeries());

    final result = await _getSearchedSeries(event.text);

    result.fold(
      (failure) => emit(const ErrorSearchedSeries()),
      (data) => emit(LoadedSearchedSeries(searchedList: data)),
    );
  }
}
