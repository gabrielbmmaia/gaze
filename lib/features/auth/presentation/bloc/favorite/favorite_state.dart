part of 'favorite_bloc.dart';

abstract class FavoriteState extends Equatable {
  const FavoriteState();

  @override
  List<Object> get props => [];
}

class FavoriteInitial extends FavoriteState {
  const FavoriteInitial();
}

class IsFavoriteItem extends FavoriteState {
  const IsFavoriteItem({required this.isFavorite});

  final bool isFavorite;

  @override
  List<bool> get props => [isFavorite];
}

class ErrorToFavoriteItem extends FavoriteState {
  const ErrorToFavoriteItem();
}

class AddedOrRemovedItem extends FavoriteState {
  const AddedOrRemovedItem({required this.isFavorite});

  final bool isFavorite;

  @override
  List<bool> get props => [isFavorite];
}

class LoadedFavoriteSeries extends FavoriteState {
  const LoadedFavoriteSeries({required this.favoriteList});

  final List<SeriesModel> favoriteList;

  @override
  List<Object> get props => [favoriteList];
}

class ErrorFavoriteSeries extends FavoriteState {
  const ErrorFavoriteSeries();
}

class LoadingFavoriteSeries extends FavoriteState {
  const LoadingFavoriteSeries();
}
