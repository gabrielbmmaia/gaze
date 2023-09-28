part of 'series_details_bloc.dart';

abstract class SeriesDetailsEvent extends Equatable {
  const SeriesDetailsEvent();
}

class LoadSeriesDetailsEvent extends SeriesDetailsEvent {
  const LoadSeriesDetailsEvent({required this.seriesId});

  final String seriesId;

  @override
  List<String> get props => [seriesId];
}
