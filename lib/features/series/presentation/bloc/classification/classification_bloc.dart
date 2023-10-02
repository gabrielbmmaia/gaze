import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gaze/features/series/domain/usecases/get_series_classification.dart';

part 'classification_event.dart';

part 'classification_state.dart';

class ClassificationBloc
    extends Bloc<ClassificationEvent, ClassificationState> {
  ClassificationBloc(
      {required GetSeriesClassificationUseCase getSeriesClassification})
      : _getSeriesClassification = getSeriesClassification,
        super(const ClassificationInitial()) {
    on<LoadClassificationEvent>(_seriesClassificationHandler);
  }

  final GetSeriesClassificationUseCase _getSeriesClassification;

  Future<void> _seriesClassificationHandler(
    LoadClassificationEvent event,
    Emitter<ClassificationState> emit,
  ) async {
    emit(const LoadingClassification());

    final result = await _getSeriesClassification(event.seriesId);

    result.fold(
      (failure) => emit(const ErrorClassification()),
      (data) => emit(LoadedClassification(classification: data)),
    );
  }
}
