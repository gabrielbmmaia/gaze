part of 'series_details_bloc.dart';

abstract class SeriesDetailsState extends Equatable {
  const SeriesDetailsState();

  @override
  List<Object> get props => [];
}

class SeriesDetailsInitial extends SeriesDetailsState {
  const SeriesDetailsInitial();
}

class LoadingSeriesDetails extends SeriesDetailsState {
  const LoadingSeriesDetails();
}

class LoadedSeriesDetails extends SeriesDetailsState {
  const LoadedSeriesDetails({required this.seriesDetails});

  final SeriesDetailsModel seriesDetails;

  @override
  List<Object> get props => [seriesDetails];
}

class ErrorSeriesDetails extends SeriesDetailsState {
  const ErrorSeriesDetails({required this.errorMessage});

  final String errorMessage;
}
