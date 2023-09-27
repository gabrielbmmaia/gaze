part of 'amazon_bloc.dart';

abstract class AmazonEvent extends Equatable {
  const AmazonEvent();

  @override
  List<Object?> get props => [];
}
class LoadAmazonListEvent extends AmazonEvent {
  const LoadAmazonListEvent();
}
