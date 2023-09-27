part of 'disney_bloc.dart';

abstract class DisneyEvent extends Equatable {
  const DisneyEvent();

  @override
  List<Object?> get props => [];
}
class LoadDisneyListEvent extends DisneyEvent {
  const LoadDisneyListEvent();
}
