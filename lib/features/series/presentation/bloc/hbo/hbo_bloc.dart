import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gaze/features/series/domain/models/series_model.dart';
import 'package:gaze/features/series/domain/usecases/get_hbo_series.dart';

part 'hbo_event.dart';

part 'hbo_state.dart';

class HboBloc extends Bloc<HboEvent, HboState> {
  HboBloc({required GetHBOSeriesUseCase getHBOSeries})
      : _getHBOSeries = getHBOSeries,
        super(const HboInitial()) {
    on<LoadHboListEvent>(_hboSeriesHandler);
  }

  final GetHBOSeriesUseCase _getHBOSeries;

  Future<void> _hboSeriesHandler(
    LoadHboListEvent event,
    Emitter<HboState> emit,
  ) async {
    emit(const LoadingHboSeries());

    final result = await _getHBOSeries();

    result.fold(
      (failure) => emit(const ErrorHboSeries()),
      (data) => emit(LoadedHboSeries(hboList: data)),
    );
  }
}
