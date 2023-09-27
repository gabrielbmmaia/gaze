part of 'hbo_bloc.dart';

abstract class HboEvent extends Equatable {
  const HboEvent();

  @override
  List<Object?> get props => [];
}
class LoadHboListEvent extends HboEvent {
  const LoadHboListEvent();
}
