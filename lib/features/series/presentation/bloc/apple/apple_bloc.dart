import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gaze/features/series/domain/models/series_model.dart';
import 'package:gaze/features/series/domain/usecases/get_apple_series.dart';

part 'apple_event.dart';

part 'apple_state.dart';

class AppleBloc extends Bloc<AppleEvent, AppleState> {
  AppleBloc({required GetAppleSeriesUseCase getAppleSeries})
      : _getAppleSeries = getAppleSeries,
        super(const AppleInitial()) {
    on<LoadAppleListEvent>(_appleSeriesHandler);
  }

  final GetAppleSeriesUseCase _getAppleSeries;

  Future<void> _appleSeriesHandler(
    LoadAppleListEvent event,
    Emitter<AppleState> emit,
  ) async {
    emit(const LoadingAppleSeries());

    final result = await _getAppleSeries();

    result.fold(
      (failure) => emit(const ErrorAppleSeries()),
      (data) => emit(LoadedAppleSeries(appleList: data)),
    );
  }
}
