part of 'netflix_bloc.dart';

abstract class NetflixState extends Equatable {
  const NetflixState();

  @override
  List<Object> get props => [];
}

class NetflixInitial extends NetflixState {
  const NetflixInitial();
}

class LoadingNetflixSeries extends NetflixState {
  const LoadingNetflixSeries();
}

class LoadedNetflixSeries extends NetflixState {
  const LoadedNetflixSeries({required this.netflixList});

  final List<SeriesModel> netflixList;

  @override
  List<Object> get props => [netflixList];
}

class ErrorNetflixSeries extends NetflixState {
  const ErrorNetflixSeries();
}
