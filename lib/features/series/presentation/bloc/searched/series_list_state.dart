part of 'series_list_bloc.dart';

abstract class SeriesListState extends Equatable {
  const SeriesListState();

  @override
  List<Object> get props => [];
}

class SeriesListInitial extends SeriesListState {
  const SeriesListInitial();
}

class LoadingSeriesList extends SeriesListState {
  const LoadingSeriesList();
}

class LoadedSeriesList extends SeriesListState {
  const LoadedSeriesList({required this.seriesList});

  final List<SeriesModel> seriesList;

  @override
  List<Object> get props => [seriesList];
}

class ErrorSeriesList extends SeriesListState {
  const ErrorSeriesList({ required this.errorMessage});

  final String errorMessage;
}
