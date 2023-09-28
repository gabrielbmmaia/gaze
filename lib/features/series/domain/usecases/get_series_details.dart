import 'package:gaze/core/usecases/usecase.dart';
import 'package:gaze/core/utils/typedefs.dart';
import 'package:gaze/features/series/domain/models/series_details_model.dart';
import 'package:gaze/features/series/domain/repositories/series_repo.dart';

class GetSeriesDetailsUseCase
    extends UseCaseWithParams<SeriesDetailsModel, String> {
  const GetSeriesDetailsUseCase(this._repo);

  final SeriesRepo _repo;

  @override
  ResultFuture<SeriesDetailsModel> call(String params) =>
      _repo.getSeriesDetails(params);
}
