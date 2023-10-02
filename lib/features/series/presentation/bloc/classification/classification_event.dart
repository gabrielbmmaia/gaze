part of 'classification_bloc.dart';

abstract class ClassificationEvent extends Equatable {
  const ClassificationEvent();

  @override
  List<Object?> get props => [];
}

class LoadClassificationEvent extends ClassificationEvent {
  const LoadClassificationEvent({required this.seriesId});

  final String seriesId;
}
