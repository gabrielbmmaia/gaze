import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gaze/core/enums/networks.dart';
import 'package:gaze/features/series/domain/models/series_model.dart';
import 'package:gaze/features/series/domain/usecases/get_network_series.dart';

part 'amazon_event.dart';

part 'amazon_state.dart';

class AmazonBloc extends Bloc<AmazonEvent, AmazonState> {
  AmazonBloc({required GetNetworkSeriesUseCase getNetworkSeries})
      : _getNetworkSeriesUseCase = getNetworkSeries,
        super(const AmazonInitial()) {
    on<LoadAmazonListEvent>(_amazonSeriesHandler);
  }

  final GetNetworkSeriesUseCase _getNetworkSeriesUseCase;

  Future<void> _amazonSeriesHandler(
    LoadAmazonListEvent event,
    Emitter<AmazonState> emit,
  ) async {
    emit(const LoadingAmazonSeries());

    final result = await _getNetworkSeriesUseCase(event.network);

    result.fold(
      (failure) => emit(const ErrorAmazonSeries()),
      (data) => emit(LoadedAmazonSeries(amazonList: data)),
    );
  }
}
