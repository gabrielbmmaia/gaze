import 'package:gaze/core/utils/typedefs.dart';
import 'package:gaze/features/series/domain/models/series_model.dart';

abstract class SeriesRepo {
  const SeriesRepo();

  ResultFuture<List<SeriesModel>> getPopularSeries();

  ResultFuture<List<SeriesModel>> getTrendingSeries();

  ResultFuture<List<SeriesModel>> getTopRatedSeries();
}
