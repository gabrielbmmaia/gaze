part of 'popular_bloc.dart';

abstract class PopularState extends Equatable {
  const PopularState();

  @override
  List<Object> get props => [];
}

class PopularInitial extends PopularState {
  const PopularInitial();
}

class LoadingPopularSeries extends PopularState {
  const LoadingPopularSeries();
}

class LoadedPopularSeries extends PopularState {
  const LoadedPopularSeries({required this.popularList});

  final List<SeriesModel> popularList;

  @override
  List<Object> get props => [popularList];
}

class ErrorPopularSeries extends PopularState {
  const ErrorPopularSeries();
}
