part of 'top_rated_bloc.dart';

abstract class TopRatedEvent extends Equatable {
  const TopRatedEvent();
}

class LoadTopRatedListEvent extends TopRatedEvent {
  const LoadTopRatedListEvent();

  @override
  List<Object?> get props => [];
}