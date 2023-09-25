import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gaze/features/series/domain/models/series_model.dart';
import 'package:gaze/features/series/domain/usecases/get_popular_series.dart';

part 'series_event.dart';

part 'series_state.dart';

class SeriesBloc extends Bloc<SeriesEvent, SeriesState> {
  SeriesBloc({
    required GetPopularSeriesUseCase getPopularSeries,
  })  : _getPopularSeries = getPopularSeries,
        super(const SeriesInitial()) {
    on<LoadPopularListEvent>(_popularSeriesHandler);
  }

  final GetPopularSeriesUseCase _getPopularSeries;

  Future<void> _popularSeriesHandler(
    LoadPopularListEvent event,
    Emitter<SeriesState> emit,
  ) async {
    emit(const LoadingPopularSeries());

    final result = await _getPopularSeries();

    result.fold(
      (failure) => emit(const ErrorPopularSeries()),
      (data) => emit(LoadedPopularSeries(popularList: data)),
    );
  }
}
