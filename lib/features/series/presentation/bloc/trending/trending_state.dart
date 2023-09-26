part of 'trending_bloc.dart';

abstract class TrendingState extends Equatable {
  const TrendingState();

  @override
  List<Object> get props => [];

}

class TrendingInitial extends TrendingState {
  const TrendingInitial();
}

class LoadingTrendingSeries extends TrendingState {
  const LoadingTrendingSeries();
}

class LoadedTrendingSeries extends TrendingState {
  const LoadedTrendingSeries({required this.trendingList});

  final List<SeriesModel> trendingList;

  @override
  List<Object> get props => [trendingList];
}

class ErrorTrendingSeries extends TrendingState {
  const ErrorTrendingSeries();
}
