import 'package:gaze/core/usecases/usecase.dart';
import 'package:gaze/core/utils/typedefs.dart';
import 'package:gaze/features/auth/domain/repositories/auth_repo.dart';
import 'package:gaze/features/series/domain/models/series_model.dart';

class IsFavoriteItemUseCase extends UseCaseWithParams<bool, SeriesModel> {
  const IsFavoriteItemUseCase(this._repo);

  final AuthRepo _repo;

  @override
  ResultFuture<bool> call(SeriesModel params) =>
      _repo.isFavoriteItem(item: params);
}
