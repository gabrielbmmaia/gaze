import 'package:gaze/core/utils/typedefs.dart';
import 'package:gaze/features/series/domain/models/series_details_model.dart';
import 'package:gaze/features/series/domain/models/series_model.dart';
import 'package:gaze/features/series/domain/models/youtube_trailers_model.dart';

abstract class SeriesRepo {
  const SeriesRepo();

  ResultFuture<List<SeriesModel>> getPopularSeries();

  ResultFuture<List<SeriesModel>> getTrendingSeries();

  ResultFuture<List<SeriesModel>> getTopRatedSeries();

  ResultFuture<List<SeriesModel>> getNetflixSeries();

  ResultFuture<List<SeriesModel>> getAmazonSeries();

  ResultFuture<List<SeriesModel>> getDisneySeries();

  ResultFuture<List<SeriesModel>> getHBOSeries();

  ResultFuture<List<SeriesModel>> getAppleSeries();

  ResultFuture<SeriesDetailsModel> getSeriesDetails(String seriesId);

  ResultFuture<List<YoutubeTrailersModel>> getYoutubeTrailers(String seriesId);

  ResultFuture<int?> getSeriesClassification(String seriesId);
}
