part of 'amazon_bloc.dart';

abstract class AmazonState extends Equatable {
  const AmazonState();

  @override
  List<dynamic> get props => [];
}

class AmazonInitial extends AmazonState {
  const AmazonInitial();
}

class LoadingAmazonSeries extends AmazonState {
  const LoadingAmazonSeries();
}

class LoadedAmazonSeries extends AmazonState {
  const LoadedAmazonSeries({
    required this.amazonList,
    this.network = Networks.amazon,
  });

  final List<SeriesModel> amazonList;
  final Networks network;

  @override
  List<dynamic> get props => [amazonList, network];
}

class ErrorAmazonSeries extends AmazonState {
  const ErrorAmazonSeries();
}
