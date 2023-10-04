part of 'hbo_bloc.dart';

abstract class HboEvent extends Equatable {
  const HboEvent();
}

class LoadHboListEvent extends HboEvent {
  const LoadHboListEvent(this.network);

  final Networks network;

  @override
  List<Object?> get props => [network];
}

