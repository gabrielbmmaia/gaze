import 'package:gaze/core/enums/genres.dart';
import 'package:gaze/core/usecases/usecase.dart';
import 'package:gaze/core/utils/typedefs.dart';
import 'package:gaze/features/series/domain/models/series_model.dart';
import 'package:gaze/features/series/domain/repositories/series_repo.dart';

class GetSeriesByGenreUseCase
    extends UseCaseWithParams<List<SeriesModel>, Genres> {
  const GetSeriesByGenreUseCase(this._repo);

  final SeriesRepo _repo;

  @override
  ResultFuture<List<SeriesModel>> call(Genres params) =>
      _repo.getSeriesByGenre(params);
}
