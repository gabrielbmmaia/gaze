import 'package:gaze/core/enums/genres.dart';
import 'package:gaze/core/enums/networks.dart';
import 'package:gaze/core/utils/typedefs.dart';
import 'package:gaze/features/series/domain/models/series_details_model.dart';
import 'package:gaze/features/series/domain/models/series_model.dart';
import 'package:gaze/features/series/domain/models/youtube_trailers_model.dart';

abstract class SeriesRepo {
  const SeriesRepo();

  ResultFuture<List<SeriesModel>> getPopularSeries();

  ResultFuture<List<SeriesModel>> getTrendingSeries();

  ResultFuture<List<SeriesModel>> getTopRatedSeries();

  ResultFuture<List<SeriesModel>> getNetworkSeries(Networks network);

  ResultFuture<SeriesDetailsModel> getSeriesDetails(String seriesId);

  ResultFuture<List<YoutubeTrailersModel>> getYoutubeTrailers(String seriesId);

  ResultFuture<String?> getSeriesClassification(String seriesId);

  ResultFuture<List<SeriesModel>> getSeriesByGenre(Genres genre);

  ResultFuture<List<SeriesModel>> getSearchedSeries(String text);
}
