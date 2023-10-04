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

// class LoadGenreListEvent extends SearchedEvent {
//   const LoadGenreListEvent({required this.genreId});
//
//   final String genreId;
//
//   @override
//   List<String> get props => [genreId];
// }
//
// class LoadNetworkListEvent extends SearchedEvent {
//   const LoadNetworkListEvent({required this.networkId});
//
//   final String networkId;
//
//   @override
//   List<String> get props => [networkId];
// }
