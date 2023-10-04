import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gaze/core/enums/networks.dart';
import 'package:gaze/features/series/domain/models/series_model.dart';
import 'package:gaze/features/series/domain/usecases/get_network_series.dart';

part 'hbo_event.dart';
part 'hbo_state.dart';

class HboBloc extends Bloc<HboEvent, HboState> {
  HboBloc({required GetNetworkSeriesUseCase getNetworkSeries})
      : _getNetworkSeriesUseCase = getNetworkSeries,
        super(const HboInitial()) {
    on<LoadHboListEvent>(_hboSeriesHandler);
  }

  final GetNetworkSeriesUseCase _getNetworkSeriesUseCase;

  Future<void> _hboSeriesHandler(
    LoadHboListEvent event,
    Emitter<HboState> emit,
  ) async {
    emit(const LoadingHboSeries());

    final result = await _getNetworkSeriesUseCase(event.network);

    result.fold(
      (failure) => emit(const ErrorHboSeries()),
      (data) => emit(LoadedHboSeries(hboList: data)),
    );
  }
}
