import 'package:gaze/core/usecases/usecase.dart';
import 'package:gaze/core/utils/typedefs.dart';
import 'package:gaze/features/series/domain/repositories/series_repo.dart';

class GetSeriesClassificationUseCase
    extends UseCaseWithParams<String?, String> {
  const GetSeriesClassificationUseCase(this._repo);

  final SeriesRepo _repo;

  @override
  ResultFuture<String?> call(String params) =>
      _repo.getSeriesClassification(params);
}
