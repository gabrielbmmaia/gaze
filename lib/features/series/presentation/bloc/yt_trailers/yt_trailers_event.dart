part of 'yt_trailers_bloc.dart';

abstract class YtTrailersEvent extends Equatable {
  const YtTrailersEvent();
}

class LoadYtTrailersEvent extends YtTrailersEvent {
  const LoadYtTrailersEvent({required this.seriesId});

  final String seriesId;

  @override
  List<String> get props => [seriesId];
}
