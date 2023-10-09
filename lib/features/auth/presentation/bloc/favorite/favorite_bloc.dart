import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gaze/features/auth/domain/usecases/add_or_remove_favorite_item.dart';
import 'package:gaze/features/auth/domain/usecases/get_favorite_series.dart';
import 'package:gaze/features/auth/domain/usecases/is_favorite_item.dart';
import 'package:gaze/features/series/domain/models/series_model.dart';

part 'favorite_event.dart';

part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  FavoriteBloc({
    required IsFavoriteItemUseCase isFavoriteItem,
    required AddOrRemoveFavoriteItemUseCase addFavoriteItem,
    required GetFavoriteSeriesUseCase getFavoriteSeries,
  })  : _isFavoriteItem = isFavoriteItem,
        _addOrRemoveFavoriteItem = addFavoriteItem,
        _getFavoriteSeries = getFavoriteSeries,
        super(const FavoriteInitial()) {
    on<IsFavoriteItemEvent>(_isFavoriteItemHandler);
    on<AddOrRemoveFavoriteItemEvent>(_addOrRemoveHandler);
    on<LoadFavoriteSeriesEvent>(_favoriteListHandler);
  }

  final IsFavoriteItemUseCase _isFavoriteItem;
  final AddOrRemoveFavoriteItemUseCase _addOrRemoveFavoriteItem;
  final GetFavoriteSeriesUseCase _getFavoriteSeries;

  Future<void> _isFavoriteItemHandler(
    IsFavoriteItemEvent event,
    Emitter<FavoriteState> emit,
  ) async {
    final result = await _isFavoriteItem(event.seriesModel);

    result.fold(
      (failure) => emit(const ErrorToFavoriteItem()),
      (data) => emit(IsFavoriteItem(isFavorite: data)),
    );
  }

  Future<void> _addOrRemoveHandler(
    AddOrRemoveFavoriteItemEvent event,
    Emitter<FavoriteState> emit,
  ) async {
    final result = await _addOrRemoveFavoriteItem(event.seriesModel);

    result.fold(
      (failure) => emit(const ErrorToFavoriteItem()),
      (data) => emit(AddedOrRemovedItem(isFavorite: data)),
    );
  }

  Future<void> _favoriteListHandler(
    LoadFavoriteSeriesEvent event,
    Emitter<FavoriteState> emit,
  ) async {
    emit(const LoadingFavoriteSeries());
    try {
      await for (final favoriteList in _getFavoriteSeries()) {
        emit(LoadedFavoriteSeries(favoriteList: favoriteList));
      }
    } catch (error) {
      emit(const ErrorFavoriteSeries());
    }
  }
}
