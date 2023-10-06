part of 'series_list_bloc.dart';

abstract class SeriesListEvent extends Equatable {
  const SeriesListEvent();

  @override
  List<Object?> get props => [];
}

class LoadSeriesListEvent extends SeriesListEvent {
  const LoadSeriesListEvent({
    required this.searchType,
    this.text,
    this.network,
    this.genre,
  });

  final String? text;
  final Networks? network;
  final Genres? genre;
  final SearchType searchType;
}
