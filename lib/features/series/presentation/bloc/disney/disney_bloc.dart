import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gaze/core/enums/networks.dart';
import 'package:gaze/features/series/domain/models/series_model.dart';
import 'package:gaze/features/series/domain/usecases/get_network_series.dart';

part 'disney_event.dart';

part 'disney_state.dart';

class DisneyBloc extends Bloc<DisneyEvent, DisneyState> {
  DisneyBloc({required GetNetworkSeriesUseCase getNetworkSeries})
      : _getNetworkSeriesUseCase = getNetworkSeries,
        super(const DisneyInitial()) {
    on<LoadDisneyListEvent>(_disneySeriesHandler);
  }

  final GetNetworkSeriesUseCase _getNetworkSeriesUseCase;

  Future<void> _disneySeriesHandler(
    LoadDisneyListEvent event,
    Emitter<DisneyState> emit,
  ) async {
    emit(const LoadingDisneySeries());

    final result = await _getNetworkSeriesUseCase(event.network);

    result.fold(
      (failure) => emit(const ErrorDisneySeries()),
      (data) => emit(LoadedDisneySeries(disneyList: data)),
    );
  }
}
