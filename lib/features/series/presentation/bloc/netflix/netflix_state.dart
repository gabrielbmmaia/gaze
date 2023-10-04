part of 'netflix_bloc.dart';

abstract class NetflixState extends Equatable {
  const NetflixState();

  @override
  List<dynamic> get props => [];
}

class NetflixInitial extends NetflixState {
  const NetflixInitial();
}

class LoadingNetflixSeries extends NetflixState {
  const LoadingNetflixSeries();
}

class LoadedNetflixSeries extends NetflixState {
  const LoadedNetflixSeries({
    required this.netflixList,
    this.network = Networks.netflix,
  });

  final List<SeriesModel> netflixList;
  final Networks network;

  @override
  List<dynamic> get props => [netflixList, network];
}

class ErrorNetflixSeries extends NetflixState {
  const ErrorNetflixSeries();
}
