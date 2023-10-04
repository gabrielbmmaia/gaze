import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gaze/core/enums/networks.dart';
import 'package:gaze/features/series/domain/models/series_model.dart';
import 'package:gaze/features/series/domain/usecases/get_network_series.dart';

part 'apple_event.dart';

part 'apple_state.dart';

class AppleBloc extends Bloc<AppleEvent, AppleState> {
  AppleBloc({required GetNetworkSeriesUseCase getNetworkSeries})
      : _getNetworkSeriesUseCase = getNetworkSeries,
        super(const AppleInitial()) {
    on<LoadAppleListEvent>(_appleSeriesHandler);
  }

  final GetNetworkSeriesUseCase _getNetworkSeriesUseCase;

  Future<void> _appleSeriesHandler(
    LoadAppleListEvent event,
    Emitter<AppleState> emit,
  ) async {
    emit(const LoadingAppleSeries());

    final result = await _getNetworkSeriesUseCase(event.network);

    result.fold(
      (failure) => emit(const ErrorAppleSeries()),
      (data) => emit(LoadedAppleSeries(appleList: data)),
    );
  }
}
