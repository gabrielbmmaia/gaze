part of 'amazon_bloc.dart';

abstract class AmazonEvent extends Equatable {
  const AmazonEvent();
}

class LoadAmazonListEvent extends AmazonEvent {
  const LoadAmazonListEvent(this.network);

  final Networks network;

  @override
  List<Object?> get props => [network];
}
