part of 'series_bloc.dart';

abstract class SeriesState extends Equatable {
  const SeriesState();

  @override
  List<Object> get props => [];
}

class SeriesInitial extends SeriesState {
  const SeriesInitial();
}

class LoadingPopularSeries extends SeriesState {
  const LoadingPopularSeries();
}

class LoadedPopularSeries extends SeriesState {
  const LoadedPopularSeries();
}

class ErrorPopularSeries extends SeriesState {
  const ErrorPopularSeries();
}
