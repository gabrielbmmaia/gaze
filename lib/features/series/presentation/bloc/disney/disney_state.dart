part of 'disney_bloc.dart';

abstract class DisneyState extends Equatable {
  const DisneyState();

  @override
  List<Object> get props => [];
}

class DisneyInitial extends DisneyState {
  const DisneyInitial();
}

class LoadingDisneySeries extends DisneyState {
  const LoadingDisneySeries();
}

class LoadedDisneySeries extends DisneyState {
  const LoadedDisneySeries({required this.disneyList});

  final List<SeriesModel> disneyList;

  @override
  List<Object> get props => [disneyList];
}

class ErrorDisneySeries extends DisneyState {
  const ErrorDisneySeries();
}
