import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gaze/core/enums/networks.dart';
import 'package:gaze/features/series/domain/models/series_model.dart';
import 'package:gaze/features/series/domain/usecases/get_network_series.dart';

part 'netflix_event.dart';
part 'netflix_state.dart';

class NetflixBloc extends Bloc<NetflixEvent, NetflixState> {
  NetflixBloc({required GetNetworkSeriesUseCase getNetworkSeries})
      : _getNetworkSeriesUseCase = getNetworkSeries,
        super(const NetflixInitial()) {
    on<LoadNetflixListEvent>(_netflixSeriesHandler);
  }

  final GetNetworkSeriesUseCase _getNetworkSeriesUseCase;

  Future<void> _netflixSeriesHandler(
    LoadNetflixListEvent event,
    Emitter<NetflixState> emit,
  ) async {
    emit(const LoadingNetflixSeries());
    final result = await _getNetworkSeriesUseCase(event.network);

    result.fold(
      (failure) => emit(const ErrorNetflixSeries()),
      (data) => emit(LoadedNetflixSeries(netflixList: data)),
    );
  }
}
