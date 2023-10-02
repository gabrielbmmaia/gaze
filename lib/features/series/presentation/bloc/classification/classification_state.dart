part of 'classification_bloc.dart';

abstract class ClassificationState extends Equatable {
  const ClassificationState();

  @override
  List<Object?> get props => [];
}

class ClassificationInitial extends ClassificationState {
  const ClassificationInitial();
}

class LoadingClassification extends ClassificationState {
  const LoadingClassification();
}

class LoadedClassification extends ClassificationState {
  const LoadedClassification({required this.classification});

  final String? classification;

  @override
  List<String?> get props => [classification];
}

class ErrorClassification extends ClassificationState {
  const ErrorClassification();
}
