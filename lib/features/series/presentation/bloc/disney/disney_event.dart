part of 'disney_bloc.dart';

abstract class DisneyEvent extends Equatable {
  const DisneyEvent();
}

class LoadDisneyListEvent extends DisneyEvent {
  const LoadDisneyListEvent(this.network);

  final Networks network;

  @override
  List<Object?> get props => [network];
}
