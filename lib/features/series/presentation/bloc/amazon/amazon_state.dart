part of 'amazon_bloc.dart';

abstract class AmazonState extends Equatable {
  const AmazonState();

  @override
  List<Object> get props => [];
}

class AmazonInitial extends AmazonState {
  const AmazonInitial();
}

class LoadingAmazonSeries extends AmazonState {
  const LoadingAmazonSeries();
}

class LoadedAmazonSeries extends AmazonState {
  const LoadedAmazonSeries({required this.amazonList});

  final List<SeriesModel> amazonList;

  @override
  List<Object> get props => [amazonList];
}

class ErrorAmazonSeries extends AmazonState {
  const ErrorAmazonSeries();
}
