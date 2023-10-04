part of 'netflix_bloc.dart';

abstract class NetflixEvent extends Equatable {
  const NetflixEvent();
}

class LoadNetflixListEvent extends NetflixEvent {
  const LoadNetflixListEvent(this.network);

  final Networks network;

  @override
  List<Object?> get props => [network];
}
