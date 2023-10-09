import 'package:gaze/core/usecases/usecase.dart';
import 'package:gaze/features/auth/domain/repositories/auth_repo.dart';
import 'package:gaze/features/series/domain/models/series_model.dart';

class GetFavoriteSeriesUseCase
    extends StreamUseCaseWithoutParams<List<SeriesModel>> {
  const GetFavoriteSeriesUseCase(this._repo);

  final AuthRepo _repo;

  @override
  Stream<List<SeriesModel>> call() => _repo.getFavoriteListStream();
}
