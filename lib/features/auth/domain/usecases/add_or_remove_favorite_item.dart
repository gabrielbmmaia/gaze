import 'package:dartz/dartz.dart';
import 'package:gaze/core/usecases/usecase.dart';
import 'package:gaze/core/utils/typedefs.dart';
import 'package:gaze/features/auth/domain/repositories/auth_repo.dart';
import 'package:gaze/features/series/domain/models/series_model.dart';

class AddOrRemoveFavoriteItemUseCase
    extends UseCaseWithParams<bool, SeriesModel> {
  const AddOrRemoveFavoriteItemUseCase(this._repo);

  final AuthRepo _repo;

  @override
  ResultFuture<bool> call(SeriesModel params) async {
    final isFavoriteResult = await _repo.isFavoriteItem(item: params);

    return isFavoriteResult.fold(
      (failure) => Left(failure),
      (isFavorite) async {
        if (isFavorite) {
          return _repo.removeFavoriteItem(item: params);
        } else {
          return _repo.addFavoriteItem(item: params);
        }
      },
    );
  }
}
