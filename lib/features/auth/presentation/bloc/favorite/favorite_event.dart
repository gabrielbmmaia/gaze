part of 'favorite_bloc.dart';

abstract class FavoriteEvent extends Equatable {
  const FavoriteEvent();
}

class AddOrRemoveFavoriteItemEvent extends FavoriteEvent {
  const AddOrRemoveFavoriteItemEvent({required this.seriesModel});

  final SeriesModel seriesModel;

  @override
  List<Object> get props => [seriesModel];
}

class IsFavoriteItemEvent extends FavoriteEvent {
  const IsFavoriteItemEvent({required this.seriesModel});

  final SeriesModel seriesModel;

  @override
  List<Object> get props => [seriesModel];
}

class LoadFavoriteSeriesEvent extends FavoriteEvent {
  const LoadFavoriteSeriesEvent();

  @override
  List<Object> get props => [];
}
