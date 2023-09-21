import 'package:gaze/core/usecases/usecase.dart';
import 'package:gaze/core/utils/typedefs.dart';
import 'package:gaze/features/series/domain/models/series_model.dart';
import 'package:gaze/features/series/domain/repositories/series_repo.dart';

class GetPopularSeries extends UseCaseWithoutParams<List<SeriesModel>> {
  const GetPopularSeries(this._repo);

  final SeriesRepo _repo;

  @override
  ResultFuture<List<SeriesModel>> call() => _repo.getPopularSeries();
}
