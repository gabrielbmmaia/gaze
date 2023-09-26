import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gaze/features/series/domain/models/series_model.dart';
import 'package:gaze/features/series/domain/usecases/get_popular_series.dart';

part 'popular_event.dart';
part 'popular_state.dart';

class PopularBloc extends Bloc<PopularEvent, PopularState> {
  PopularBloc({
    required GetPopularSeriesUseCase getPopularSeries
  })  : _getPopularSeries = getPopularSeries,
        super(const PopularInitial()) {
    on<LoadPopularListEvent>(_popularSeriesHandler);
  }

  final GetPopularSeriesUseCase _getPopularSeries;

  Future<void> _popularSeriesHandler(
    LoadPopularListEvent event,
    Emitter<PopularState> emit,
  ) async {
    emit(const LoadingPopularSeries());

    final result = await _getPopularSeries();

    result.fold(
      (failure) => emit(const ErrorPopularSeries()),
      (data) => emit(LoadedPopularSeries(popularList: data)),
    );
  }
}
