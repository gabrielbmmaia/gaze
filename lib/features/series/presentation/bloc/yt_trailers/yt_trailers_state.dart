part of 'yt_trailers_bloc.dart';

abstract class YtTrailersState extends Equatable {
  const YtTrailersState();

  @override
  List<Object> get props => [];
}

class YtTrailersInitial extends YtTrailersState {
  const YtTrailersInitial();
}

class LoadingYtTrailers extends YtTrailersState {
  const LoadingYtTrailers();
}

class LoadedYtTrailers extends YtTrailersState {
  const LoadedYtTrailers({required this.trailersList});

  final List<YoutubeTrailersModel> trailersList;

  @override
  List<Object> get props => [trailersList];
}

class ErrorYtTrailers extends YtTrailersState {
  const ErrorYtTrailers();
}
