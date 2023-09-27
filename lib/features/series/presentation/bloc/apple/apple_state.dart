part of 'apple_bloc.dart';

abstract class AppleState extends Equatable {
  const AppleState();

  @override
  List<Object> get props => [];
}

class AppleInitial extends AppleState {
  const AppleInitial();
}

class LoadingAppleSeries extends AppleState {
  const LoadingAppleSeries();
}

class LoadedAppleSeries extends AppleState {
  const LoadedAppleSeries({required this.appleList});

  final List<SeriesModel> appleList;

  @override
  List<Object> get props => [appleList];
}

class ErrorAppleSeries extends AppleState {
  const ErrorAppleSeries();
}
