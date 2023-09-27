part of 'apple_bloc.dart';

abstract class AppleEvent extends Equatable {
  const AppleEvent();

  @override
  List<Object?> get props => [];
}
class LoadAppleListEvent extends AppleEvent {
  const LoadAppleListEvent();
}
