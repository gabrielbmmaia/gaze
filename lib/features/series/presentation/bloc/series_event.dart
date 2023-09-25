part of 'series_bloc.dart';

abstract class SeriesEvent extends Equatable {
  const SeriesEvent();

  @override
  List<Object?> get props => [];
}

class LoadPopularListEvent extends SeriesEvent {
  const LoadPopularListEvent();
}
