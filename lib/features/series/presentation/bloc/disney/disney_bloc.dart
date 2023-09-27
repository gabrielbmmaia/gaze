import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gaze/features/series/domain/models/series_model.dart';
import 'package:gaze/features/series/domain/usecases/get_disney_series.dart';

part 'disney_event.dart';

part 'disney_state.dart';

class DisneyBloc extends Bloc<DisneyEvent, DisneyState> {
  DisneyBloc({required GetDisneySeriesUseCase getDisneySeries})
      : _getDisneySeries = getDisneySeries,
        super(const DisneyInitial()) {
    on<LoadDisneyListEvent>(_disneySeriesHandler);
  }

  final GetDisneySeriesUseCase _getDisneySeries;

  Future<void> _disneySeriesHandler(
    LoadDisneyListEvent event,
    Emitter<DisneyState> emit,
  ) async {
    emit(const LoadingDisneySeries());

    final result = await _getDisneySeries();

    result.fold(
      (failure) => emit(const ErrorDisneySeries()),
      (data) => emit(LoadedDisneySeries(disneyList: data)),
    );
  }
}
