import 'dart:convert';
import 'package:gaze/core/errors/exceptions.dart';
import 'package:gaze/core/utils/typedefs.dart';
import 'package:gaze/features/series/data/models/series_entity.dart';
import 'package:gaze/features/series/data/models/series_request.dart';
import 'package:http/http.dart' as http;

const String kBaseUrl = 'http://api.themoviedb.org/3';
const kGetPopularSeriesEndpoint = '/tv/popular';
const kTmdbApiKey = '24e29501a7520a99e65304fad758b78b';

abstract class SeriesRemoteDataSource {
  const SeriesRemoteDataSource();

  Future<List<SeriesEntity>> getPopularSeries();
}

class SeriesRemoteDataSourceImpl extends SeriesRemoteDataSource {
  const SeriesRemoteDataSourceImpl(this._client);

  final http.Client _client;

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
      final seriesRequest = SeriesRequest.fromJson(
        jsonDecode(response.body) as DataMap,
      );
      print(seriesRequest.runtimeType);
      return seriesRequest.result;
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString(), statusCode: '505');
    }
  }
}
