import 'package:gaze/core/usecases/usecase.dart';
import 'package:gaze/core/utils/typedefs.dart';
import 'package:gaze/features/auth/domain/repositories/auth_repo.dart';
import 'package:gaze/features/series/domain/models/series_model.dart';

class AddFavoriteItemUseCase extends UseCaseWithParams<void, SeriesModel> {
  const AddFavoriteItemUseCase(this._repo);

  final AuthRepo _repo;

  @override
  ResultFuture<void> call(SeriesModel params) =>
      _repo.addFavoriteItem(item: params);
}
