part of 'apple_bloc.dart';

abstract class AppleState extends Equatable {
  const AppleState();

  @override
  List<dynamic> get props => [];
}

class AppleInitial extends AppleState {
  const AppleInitial();
}

class LoadingAppleSeries extends AppleState {
  const LoadingAppleSeries();
}

class LoadedAppleSeries extends AppleState {
  const LoadedAppleSeries({
    required this.appleList,
    this.network = Networks.apple,
  });

  final List<SeriesModel> appleList;
  final Networks network;

  @override
  List<dynamic> get props => [appleList, network];
}

class ErrorAppleSeries extends AppleState {
  const ErrorAppleSeries();
}
