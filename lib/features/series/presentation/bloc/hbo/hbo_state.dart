part of 'hbo_bloc.dart';

abstract class HboState extends Equatable {
  const HboState();

  @override
  List<Object> get props => [];
}

class HboInitial extends HboState {
  const HboInitial();
}

class LoadingHboSeries extends HboState {
  const LoadingHboSeries();
}

class LoadedHboSeries extends HboState {
  const LoadedHboSeries({required this.hboList});

  final List<SeriesModel> hboList;

  @override
  List<Object> get props => [hboList];
}

class ErrorHboSeries extends HboState {
  const ErrorHboSeries();
}
