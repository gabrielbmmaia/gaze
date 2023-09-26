part of 'top_rated_bloc.dart';

abstract class TopRatedState extends Equatable {
  const TopRatedState();

  @override
  List<Object> get props => [];
}

class TopRatedInitial extends TopRatedState {
  const TopRatedInitial();
}

class LoadingTopRatedSeries extends TopRatedState {
  const LoadingTopRatedSeries();
}

class LoadedTopRatedSeries extends TopRatedState {
  const LoadedTopRatedSeries({required this.topRatedList});

  final List<SeriesModel> topRatedList;

  @override
  List<Object> get props => [topRatedList];
}

class ErrorTopRatedSeries extends TopRatedState {
  const ErrorTopRatedSeries();
}
