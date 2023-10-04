part of 'apple_bloc.dart';

abstract class AppleEvent extends Equatable {
  const AppleEvent();
}

class LoadAppleListEvent extends AppleEvent {
  const LoadAppleListEvent(this.network);

  final Networks network;

  @override
  List<Object?> get props => [network];
}
