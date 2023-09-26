part of 'netflix_bloc.dart';

abstract class NetflixEvent extends Equatable {
  const NetflixEvent();

  @override
  List<Object?> get props => [];
}
class LoadNetflixListEvent extends NetflixEvent {
  const LoadNetflixListEvent();
}
