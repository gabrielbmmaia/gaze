import 'dart:convert';

import 'package:gaze/core/errors/exceptions.dart';
import 'package:gaze/features/series/data/data_sources/interceptor.dart';
import 'package:gaze/features/series/data/models/series_details_entity.dart';
import 'package:gaze/features/series/data/models/series_entity.dart';
import 'package:gaze/features/series/data/models/youtube_trailers_entity.dart';
import 'package:http_interceptor/http_interceptor.dart';

const String kBaseUrl = 'http://api.themoviedb.org/3';
const kGetPopularSeriesEndpoint = '/tv/popular';
const kGetTrendingSeriesEndpoint = '/trending/tv';
const kGetTopRatedSeriesEndpoint = '/tv/top_rated';
const kGetDiscoverSeriesEndpoint = '/discover/tv';
const kGetSeriesDetailsEndpoint = '/tv';
const kGetSearchEndpoint = '/search/tv';
const kTmdbApiKey = '24e29501a7520a99e65304fad758b78b';
const kImageBaseUrl = 'https://image.tmdb.org/t/p/w500';

abstract class SeriesRemoteDataSource {
  const SeriesRemoteDataSource();

  Future<List<SeriesEntity>> getPopularSeries();

  Future<List<SeriesEntity>> getTrendingSeries();

  Future<List<SeriesEntity>> getTopRatedSeries();

  Future<List<SeriesEntity>> getNetflixSeries();

  Future<List<SeriesEntity>> getAmazonSeries();

  Future<List<SeriesEntity>> getDisneySeries();

  Future<List<SeriesEntity>> getHBOSeries();

  Future<List<SeriesEntity>> getAppleSeries();

  Future<SeriesDetailsEntity> getSeriesDetails(String seriesId);

  Future<List<YoutubeTrailersEntity>> getYoutubeTrailers(String seriesId);

  Future<String?> getSeriesClassification(String seriesId);

  Future<List<SeriesEntity>> getSeriesByGenre(String genreId);

  Future<List<SeriesEntity>> getSearchedSeries(String text);
}

class SeriesRemoteDataSourceImpl extends SeriesRemoteDataSource {
  SeriesRemoteDataSourceImpl();

  final _client = InterceptedClient.build(interceptors: [LoggingInterceptor()]);

  @override
  Future<List<SeriesEntity>> getPopularSeries() async {
    try {
      final response = await _client.get(
        Uri.parse('$kBaseUrl$kGetPopularSeriesEndpoint?api_key=$kTmdbApiKey'),
      );
      if (response.statusCode != 200) {
        throw ServerException(
          message: response.body,
          statusCode: response.statusCode.toString(),
        );
      }

      final data = jsonDecode(response.body)['results'] as List<dynamic>;
      return data
          .map<SeriesEntity>(
            (series) => SeriesEntity.fromJson(series as Map<String, dynamic>),
          )
          .toList();
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString(), statusCode: '505');
    }
  }

  @override
  Future<List<SeriesEntity>> getTrendingSeries() async {
    try {
      final response = await _client.get(
        Uri.parse(
            '$kBaseUrl$kGetTrendingSeriesEndpoint/day?api_key=$kTmdbApiKey'),
      );
      if (response.statusCode != 200) {
        throw ServerException(
          message: response.body,
          statusCode: response.statusCode.toString(),
        );
      }
      final data = jsonDecode(response.body)['results'] as List<dynamic>;
      return data
          .map<SeriesEntity>(
            (series) => SeriesEntity.fromJson(series as Map<String, dynamic>),
          )
          .toList();
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString(), statusCode: '505');
    }
  }

  @override
  Future<List<SeriesEntity>> getTopRatedSeries() async {
    try {
      final response = await _client.get(
        Uri.parse(
          '$kBaseUrl$kGetTopRatedSeriesEndpoint?api_key=$kTmdbApiKey',
        ),
      );
      if (response.statusCode != 200) {
        throw ServerException(
          message: response.body,
          statusCode: response.statusCode.toString(),
        );
      }
      final data = jsonDecode(response.body)['results'] as List<dynamic>;
      return data
          .map(
            (series) => SeriesEntity.fromJson(series as Map<String, dynamic>),
          )
          .toList();
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString(), statusCode: '505');
    }
  }

  @override
  Future<List<SeriesEntity>> getNetflixSeries() async {
    try {
      final response = await _client.get(
        Uri.parse(
          '$kBaseUrl$kGetDiscoverSeriesEndpoint?api_key=$kTmdbApiKey'
          '&with_networks=213',
        ),
      );
      if (response.statusCode != 200) {
        throw ServerException(
          message: response.body,
          statusCode: response.statusCode.toString(),
        );
      }
      final data = jsonDecode(response.body)['results'] as List<dynamic>;
      return data
          .map(
            (series) => SeriesEntity.fromJson(series as Map<String, dynamic>),
          )
          .toList();
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString(), statusCode: '505');
    }
  }

  @override
  Future<List<SeriesEntity>> getAmazonSeries() async {
    try {
      final response = await _client.get(
        Uri.parse(
          '$kBaseUrl$kGetDiscoverSeriesEndpoint?api_key=$kTmdbApiKey'
          '&with_networks=1024',
        ),
      );
      if (response.statusCode != 200) {
        throw ServerException(
          message: response.body,
          statusCode: response.statusCode.toString(),
        );
      }
      final data = jsonDecode(response.body)['results'] as List<dynamic>;
      return data
          .map(
            (series) => SeriesEntity.fromJson(series as Map<String, dynamic>),
          )
          .toList();
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString(), statusCode: '505');
    }
  }

  @override
  Future<List<SeriesEntity>> getDisneySeries() async {
    try {
      final response = await _client.get(
        Uri.parse(
          '$kBaseUrl$kGetDiscoverSeriesEndpoint?api_key=$kTmdbApiKey'
          '&with_networks=2739',
        ),
      );
      if (response.statusCode != 200) {
        throw ServerException(
          message: response.body,
          statusCode: response.statusCode.toString(),
        );
      }
      final data = jsonDecode(response.body)['results'] as List<dynamic>;
      return data
          .map(
            (series) => SeriesEntity.fromJson(series as Map<String, dynamic>),
          )
          .toList();
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString(), statusCode: '505');
    }
  }

  @override
  Future<List<SeriesEntity>> getHBOSeries() async {
    try {
      final response = await _client.get(
        Uri.parse(
          '$kBaseUrl$kGetDiscoverSeriesEndpoint?api_key=$kTmdbApiKey'
          '&with_networks=49',
        ),
      );
      if (response.statusCode != 200) {
        throw ServerException(
          message: response.body,
          statusCode: response.statusCode.toString(),
        );
      }
      final data = jsonDecode(response.body)['results'] as List<dynamic>;
      return data
          .map(
            (series) => SeriesEntity.fromJson(series as Map<String, dynamic>),
          )
          .toList();
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString(), statusCode: '505');
    }
  }

  @override
  Future<List<SeriesEntity>> getAppleSeries() async {
    try {
      final response = await _client.get(
        Uri.parse(
          '$kBaseUrl$kGetDiscoverSeriesEndpoint?api_key=$kTmdbApiKey'
          '&with_networks=2552',
        ),
      );
      if (response.statusCode != 200) {
        throw ServerException(
          message: response.body,
          statusCode: response.statusCode.toString(),
        );
      }
      final data = jsonDecode(response.body)['results'] as List<dynamic>;
      return data
          .map(
            (series) => SeriesEntity.fromJson(series as Map<String, dynamic>),
          )
          .toList();
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString(), statusCode: '505');
    }
  }

  @override
  Future<SeriesDetailsEntity> getSeriesDetails(
    String seriesId,
  ) async {
    try {
      final response = await _client.get(
        Uri.parse(
          '$kBaseUrl$kGetSeriesDetailsEndpoint/$seriesId?api_key=$kTmdbApiKey&language=pt-BR',
        ),
      );
      if (response.statusCode != 200) {
        throw ServerException(
          message: response.body,
          statusCode: response.statusCode.toString(),
        );
      }
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      return SeriesDetailsEntity.fromJson(data);
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString(), statusCode: '505');
    }
  }

  @override
  Future<List<YoutubeTrailersEntity>> getYoutubeTrailers(
    String seriesId,
  ) async {
    try {
      final response = await _client.get(
        Uri.parse(
          '$kBaseUrl/tv/$seriesId/videos?api_key=$kTmdbApiKey',
        ),
      );
      if (response.statusCode != 200) {
        throw ServerException(
          message: response.body,
          statusCode: response.statusCode.toString(),
        );
      }
      final data = jsonDecode(response.body)['results'] as List<dynamic>;
      return data
          .map((videos) =>
              YoutubeTrailersEntity.fromMap(videos as Map<String, dynamic>))
          .toList();
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString(), statusCode: '505');
    }
  }

  @override
  Future<String?> getSeriesClassification(String seriesId) async {
    try {
      final response = await _client.get(
        Uri.parse(
          '$kBaseUrl/tv/$seriesId/content_ratings?api_key=$kTmdbApiKey',
        ),
      );
      if (response.statusCode != 200) {
        throw ServerException(
          message: response.body,
          statusCode: response.statusCode.toString(),
        );
      }
      final data = jsonDecode(response.body)['results'] as List<dynamic>;
      final result = data.firstWhere(
        (rating) => rating['iso_3166_1'] == 'BR',
        orElse: () => null,
      );
      return result != null ? result['rating'] as String : null;
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString(), statusCode: '505');
    }
  }

  @override
  Future<List<SeriesEntity>> getSeriesByGenre(String genreId) async {
    try {
      final response = await _client.get(
        Uri.parse(
          '$kBaseUrl$kGetDiscoverSeriesEndpoint?api_key=$kTmdbApiKey'
          '&with_genres=$genreId',
        ),
      );
      if (response.statusCode != 200) {
        throw ServerException(
          message: response.body,
          statusCode: response.statusCode.toString(),
        );
      }
      final data = jsonDecode(response.body)['results'] as List<dynamic>;
      return data
          .map(
            (series) => SeriesEntity.fromJson(series as Map<String, dynamic>),
          )
          .toList();
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString(), statusCode: '505');
    }
  }

  @override
  Future<List<SeriesEntity>> getSearchedSeries(String text) async {
    try {
      final response = await _client.get(
        Uri.parse(
          '$kBaseUrl$kGetSearchEndpoint?api_key=$kTmdbApiKey&query=$text',
        ),
      );
      if (response.statusCode != 200) {
        throw ServerException(
          message: response.body,
          statusCode: response.statusCode.toString(),
        );
      }
      final data = jsonDecode(response.body)['results'] as List<dynamic>;
      return data
          .map(
            (series) => SeriesEntity.fromJson(series as Map<String, dynamic>),
          )
          .toList();
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString(), statusCode: '505');
    }
  }
}
