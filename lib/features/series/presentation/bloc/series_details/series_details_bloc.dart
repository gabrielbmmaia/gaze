import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gaze/features/series/domain/models/series_details_model.dart';
import 'package:gaze/features/series/domain/usecases/get_series_details.dart';

part 'series_details_event.dart';

part 'series_details_state.dart';

class SeriesDetailsBloc extends Bloc<SeriesDetailsEvent, SeriesDetailsState> {
  SeriesDetailsBloc({required GetSeriesDetailsUseCase getSeriesDetails})
      : _getSeriesDetails = getSeriesDetails,
        super(const SeriesDetailsInitial()) {
    on<LoadSeriesDetailsEvent>(_getSeriesDetailsHandler);
  }

  final GetSeriesDetailsUseCase _getSeriesDetails;

  Future<void> _getSeriesDetailsHandler(
    LoadSeriesDetailsEvent event,
    Emitter<SeriesDetailsState> emit,
  ) async {
    emit(const LoadingSeriesDetails());

    final result = await _getSeriesDetails(event.seriesId);

    result.fold(
      (failure) => emit(const ErrorSeriesDetails()),
      (data) => emit(LoadedSeriesDetails(seriesDetails: data)),
    );
  }
}
