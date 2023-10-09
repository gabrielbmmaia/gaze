import 'package:dartz/dartz.dart';
import 'package:gaze/core/enums/genres.dart';
import 'package:gaze/core/enums/networks.dart';
import 'package:gaze/core/errors/exceptions.dart';
import 'package:gaze/core/errors/failures.dart';
import 'package:gaze/core/utils/typedefs.dart';
import 'package:gaze/features/series/data/data_sources/series_remote_data_source.dart';
import 'package:gaze/features/series/domain/models/series_details_model.dart';
import 'package:gaze/features/series/domain/models/series_model.dart';
import 'package:gaze/features/series/domain/models/youtube_trailers_model.dart';
import 'package:gaze/features/series/domain/repositories/series_repo.dart';

class SeriesRepoImpl implements SeriesRepo {
  const SeriesRepoImpl(this._remoteDataSource);

  final SeriesRemoteDataSource _remoteDataSource;

  @override
  ResultFuture<List<SeriesModel>> getPopularSeries() async {
    try {
      final result = await _remoteDataSource.getPopularSeries();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<SeriesModel>> getTrendingSeries() async {
    try {
      final result = await _remoteDataSource.getTrendingSeries();
      return Right(result.getRange(0, 10).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<SeriesModel>> getTopRatedSeries() async {
    try {
      final result = await _remoteDataSource.getTopRatedSeries();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<SeriesDetailsModel> getSeriesDetails(String seriesId) async {
    try {
      final result = await _remoteDataSource.getSeriesDetails(seriesId);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<YoutubeTrailersModel>> getYoutubeTrailers(
    String seriesId,
  ) async {
    try {
      final result = await _remoteDataSource.getYoutubeTrailers(seriesId);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<String?> getSeriesClassification(String seriesId) async {
    try {
      final result = await _remoteDataSource.getSeriesClassification(seriesId);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<SeriesModel>> getSeriesByGenre(Genres genre) async {
    try {
      final result = await _remoteDataSource.getSeriesByGenre(getGenresId[genre]!);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<SeriesModel>> getSearchedSeries(String text) async {
    try {
      final result = await _remoteDataSource.getSearchedSeries(text);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<SeriesModel>> getNetworkSeries(Networks network) async {
    try {
      final result = await _remoteDataSource.getNetworkSeries(
        getNetworkId[network]!,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }
}
