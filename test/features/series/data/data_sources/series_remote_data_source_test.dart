import 'dart:convert';
import 'package:gaze/features/series/data/data_sources/series_remote_data_source.dart';
import 'package:gaze/features/series/data/models/series_request.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  late http.Client client;
  late SeriesRemoteDataSource remoteDataSource;

  setUp(() {
    client = MockClient();
    remoteDataSource = SeriesRemoteDataSourceImpl(client);
    registerFallbackValue(Uri());
  });

  group('getPopularSeries', () {
    final tSeriesRequest = SeriesRequest.empty();
    test(
      'should return [SeriesRequest] when status code is 200',
      () async {
        when(() => client.get(any())).thenAnswer(
          (_) async =>
              http.Response(jsonEncode([tSeriesRequest.toMap()]), 200),
        );

        final result = await remoteDataSource.getPopularSeries();

        expect(result, tSeriesRequest);
        verify(
          () => client.get(
            Uri.parse(
              '$kBaseUrl$kGetPopularSeriesEndpoint?api_key=$kTmdbApiKey',
            ),
          ),
        ).called(1);
        verifyNoMoreInteractions(client);
      },
    );
  });
}
