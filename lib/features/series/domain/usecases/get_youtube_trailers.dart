import 'package:gaze/core/usecases/usecase.dart';
import 'package:gaze/core/utils/typedefs.dart';
import 'package:gaze/features/series/domain/models/youtube_trailers_model.dart';
import 'package:gaze/features/series/domain/repositories/series_repo.dart';

class GetYoutubeTrailersUseCase
    extends UseCaseWithParams<List<YoutubeTrailersModel>, String> {
  const GetYoutubeTrailersUseCase(this._repo);

  final SeriesRepo _repo;

  @override
  ResultFuture<List<YoutubeTrailersModel>> call(String params) =>
      _repo.getYoutubeTrailers(params);
}
