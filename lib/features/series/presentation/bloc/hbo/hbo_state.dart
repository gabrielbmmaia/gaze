part of 'hbo_bloc.dart';

abstract class HboState extends Equatable {
  const HboState();

  @override
  List<dynamic> get props => [];
}

class HboInitial extends HboState {
  const HboInitial();
}

class LoadingHboSeries extends HboState {
  const LoadingHboSeries();
}

class LoadedHboSeries extends HboState {
  const LoadedHboSeries({
    required this.hboList,
    this.network = Networks.hbo,
  });

  final List<SeriesModel> hboList;
  final Networks network;

  @override
  List<dynamic> get props => [hboList, network];
}

class ErrorHboSeries extends HboState {
  const ErrorHboSeries();
}
