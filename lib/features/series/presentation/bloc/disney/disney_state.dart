part of 'disney_bloc.dart';

abstract class DisneyState extends Equatable {
  const DisneyState();

  @override
  List<dynamic> get props => [];
}

class DisneyInitial extends DisneyState {
  const DisneyInitial();
}

class LoadingDisneySeries extends DisneyState {
  const LoadingDisneySeries();
}

class LoadedDisneySeries extends DisneyState {
  const LoadedDisneySeries({
    required this.disneyList,
    this.network = Networks.disney,
  });

  final List<SeriesModel> disneyList;
  final Networks network;

  @override
  List<dynamic> get props => [disneyList, network];
}

class ErrorDisneySeries extends DisneyState {
  const ErrorDisneySeries();
}
