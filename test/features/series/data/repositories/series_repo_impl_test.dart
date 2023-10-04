import 'package:dartz/dartz.dart';
import 'package:gaze/core/enums/genres.dart';
import 'package:gaze/core/enums/networks.dart';
import 'package:gaze/core/errors/exceptions.dart';
import 'package:gaze/core/errors/failures.dart';
import 'package:gaze/features/series/data/data_sources/series_remote_data_source.dart';
import 'package:gaze/features/series/data/models/series_details_entity.dart';
import 'package:gaze/features/series/data/models/series_entity.dart';
import 'package:gaze/features/series/data/models/youtube_trailers_entity.dart';
import 'package:gaze/features/series/data/repositories/series_repo_impl.dart';
import 'package:gaze/features/series/domain/models/series_details_model.dart';
import 'package:gaze/features/series/domain/models/series_model.dart';
import 'package:gaze/features/series/domain/models/youtube_trailers_model.dart';
import 'package:gaze/features/series/domain/repositories/series_repo.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockSeriesRemoteDataSource extends Mock
    implements SeriesRemoteDataSource {}

void main() {
  late SeriesRemoteDataSource remoteDataSource;
  late SeriesRepo repo;

  setUp(() {
    remoteDataSource = MockSeriesRemoteDataSource();
    repo = SeriesRepoImpl(remoteDataSource);
    registerFallbackValue(Networks.netflix);
    registerFallbackValue(Genres.animation);
  });

  const tSeriesEntityList = [
    SeriesEntity.empty(),
    SeriesEntity.empty(),
    SeriesEntity.empty(),
    SeriesEntity.empty(),
    SeriesEntity.empty(),
    SeriesEntity.empty(),
    SeriesEntity.empty(),
    SeriesEntity.empty(),
    SeriesEntity.empty(),
    SeriesEntity.empty(),
  ];
  const tServerException = ServerException(
    message: 'Test Exception',
    statusCode: '505',
  );

  group('getPopularSeries', () {
    test(
      'should call [SeriesRemoteDataSource.getPopularSeries] and return '
      '[Right<List<SeriesModel>>] when the call is successful',
      () async {
        when(() => remoteDataSource.getPopularSeries()).thenAnswer(
          (_) async => tSeriesEntityList,
        );

        final result = await repo.getPopularSeries();

        expect(
          result,
          isA<Right<dynamic, List<SeriesModel>>>(),
        );
        verify(() => remoteDataSource.getPopularSeries()).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );
    test(
      'should return [Left<ServerFailure>] when the call is unsuccessful',
      () async {
        when(() => remoteDataSource.getPopularSeries())
            .thenThrow(tServerException);

        final result = await repo.getPopularSeries();

        expect(
          result,
          Left<ServerFailure, dynamic>(
            ServerFailure.fromException(tServerException),
          ),
        );
        verify(() => remoteDataSource.getPopularSeries()).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );
  });

  group('getTrendingSeries', () {
    test(
      'should call [SeriesRemoteDataSource.getTrendingSeries] and return '
      '[Right<List<SeriesModel>>] when the call is successful',
      () async {
        when(() => remoteDataSource.getTrendingSeries()).thenAnswer(
          (_) async => tSeriesEntityList,
        );

        final result = await repo.getTrendingSeries();

        expect(result, isA<Right<dynamic, List<SeriesModel>>>());
        verify(() => remoteDataSource.getTrendingSeries()).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );
    test(
      'should return [Left<ServerFailure>] when the call is unsuccessful',
      () async {
        when(() => remoteDataSource.getTrendingSeries())
            .thenThrow(tServerException);

        final result = await repo.getTrendingSeries();

        expect(
          result,
          Left<ServerFailure, dynamic>(
            ServerFailure.fromException(tServerException),
          ),
        );
        verify(() => remoteDataSource.getTrendingSeries()).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );
  });

  group('getTopRatedSeries', () {
    test(
      'should call [SeriesRemoteDataSource.getTopRatedSeries] and return '
      '[Right<List<SeriesModel>] when the call is successful',
      () async {
        when(() => remoteDataSource.getTopRatedSeries()).thenAnswer(
          (_) async => tSeriesEntityList,
        );

        final result = await repo.getTopRatedSeries();

        expect(
          result,
          isA<Right<dynamic, List<SeriesModel>>>(),
        );
        verify(() => remoteDataSource.getTopRatedSeries()).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );
    test(
      'should return [Left<ServerFailure>] when the call is unsuccessful',
      () async {
        when(() => remoteDataSource.getTopRatedSeries())
            .thenThrow(tServerException);

        final result = await repo.getTopRatedSeries();

        expect(
          result,
          Left<ServerFailure, dynamic>(
            ServerFailure.fromException(tServerException),
          ),
        );
        verify(() => remoteDataSource.getTopRatedSeries()).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );
  });

  group('getNetworkSeries', () {
    test(
      'should call [SeriesRemoteDataSource.getNetworkSeries] and return '
      '[Right<List<SeriesModel>>] when the call is successful',
      () async {
        when(() => remoteDataSource.getNetworkSeries(any())).thenAnswer(
          (_) async => tSeriesEntityList,
        );

        final result = await repo.getNetworkSeries(Networks.netflix);

        expect(
          result,
          isA<Right<dynamic, List<SeriesModel>>>(),
        );
        verify(
          () => remoteDataSource
              .getNetworkSeries(getNetworkId[Networks.netflix]!),
        ).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );
    test(
      'should return [Left<ServerFailure>] when the call is unsuccessful',
      () async {
        when(() => remoteDataSource.getNetworkSeries(any()))
            .thenThrow(tServerException);

        final result = await repo.getNetworkSeries(Networks.netflix);

        expect(
          result,
          Left<ServerFailure, dynamic>(
            ServerFailure.fromException(tServerException),
          ),
        );
        verify(
          () => remoteDataSource
              .getNetworkSeries(getNetworkId[Networks.netflix]!),
        ).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );
  });

  group('getSeriesDetails', () {
    final tSeriesDetails = SeriesDetailsEntity.empty();
    test(
      'should call [SeriesRemoteDataSource.getSeriesDetails] and return '
      '[Right<SeriesDetailsModel>] when the call is successful',
      () async {
        when(() => remoteDataSource.getSeriesDetails(any())).thenAnswer(
          (_) async => tSeriesDetails,
        );

        final result = await repo.getSeriesDetails('123456');

        expect(result, Right<dynamic, SeriesDetailsModel>(tSeriesDetails));
        verify(() => remoteDataSource.getSeriesDetails('123456')).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );
    test(
      'should return [Left<ServerFailure>] when the call is unsuccessful',
      () async {
        when(() => remoteDataSource.getSeriesDetails(any()))
            .thenThrow(tServerException);

        final result = await repo.getSeriesDetails('123456');

        expect(
          result,
          Left<Failure, dynamic>(
            ServerFailure.fromException(tServerException),
          ),
        );
        verify(() => remoteDataSource.getSeriesDetails('123456')).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );
  });

  group('getYoutubeTrailers', () {
    const tTrailersList = [YoutubeTrailersEntity.empty()];
    test(
      'should call [SeriesRemoteDataSource.getYoutubeTrailers] and return '
      '[Right<List<YoutubeTrailersEntity>>] when the call is successful',
      () async {
        when(() => remoteDataSource.getYoutubeTrailers(any())).thenAnswer(
          (_) async => tTrailersList,
        );

        final result = await repo.getYoutubeTrailers('123456');

        expect(
          result,
          const Right<dynamic, List<YoutubeTrailersModel>>(tTrailersList),
        );
        verify(() => remoteDataSource.getYoutubeTrailers('123456')).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );
    test(
      'should return [Left<ServerFailure>] when the call is unsuccessful',
      () async {
        when(() => remoteDataSource.getYoutubeTrailers(any()))
            .thenThrow(tServerException);

        final result = await repo.getYoutubeTrailers('123456');

        expect(
          result,
          Left<Failure, dynamic>(
            ServerFailure.fromException(tServerException),
          ),
        );
        verify(() => remoteDataSource.getYoutubeTrailers('123456')).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );
  });

  group('getSeriesClassification', () {
    test(
      'should call [SeriesRemoteDataSource.getSeriesClassification] and return '
      '[Right<int?>] when the call is successful',
      () async {
        when(() => remoteDataSource.getSeriesClassification(any())).thenAnswer(
          (_) async => '14',
        );

        final result = await repo.getSeriesClassification('123456');

        expect(
          result,
          const Right<dynamic, String?>('14'),
        );
        verify(() => remoteDataSource.getSeriesClassification('123456'))
            .called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );
    test(
      'should return [Left<ServerFailure>] when the call is unsuccessful',
      () async {
        when(() => remoteDataSource.getSeriesClassification(any()))
            .thenThrow(tServerException);

        final result = await repo.getSeriesClassification('123456');

        expect(
          result,
          Left<Failure, dynamic>(
            ServerFailure.fromException(tServerException),
          ),
        );
        verify(() => remoteDataSource.getSeriesClassification('123456'))
            .called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );
  });

  group('getSeriesByGenre', () {
    test(
      'should call [SeriesRemoteDataSource.getSeriesByGenre] and return '
      '[Right<List<SeriesModel>>] when the call is successful',
      () async {
        when(() => remoteDataSource.getSeriesByGenre(any())).thenAnswer(
          (_) async => tSeriesEntityList,
        );

        final result = await repo.getSeriesByGenre(Genres.animation);

        expect(
          result,
          const Right<dynamic, List<SeriesModel>>(tSeriesEntityList),
        );
        verify(
          () => remoteDataSource.getSeriesByGenre(genreIds[Genres.animation]!),
        ).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );
    test(
      'should return [Left<ServerFailure>] when the call is unsuccessful',
      () async {
        when(() => remoteDataSource.getSeriesByGenre(any()))
            .thenThrow(tServerException);

        final result = await repo.getSeriesByGenre(Genres.animation);

        expect(
          result,
          Left<Failure, dynamic>(
            ServerFailure.fromException(tServerException),
          ),
        );
        verify(
          () => remoteDataSource.getSeriesByGenre(genreIds[Genres.animation]!),
        ).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );
  });

  group('getSearchedSeries', () {
    test(
      'should call [SeriesRemoteDataSource.getSearchedSeries] and return '
      '[Right<List<SeriesModel>>] when the call is successful',
      () async {
        when(() => remoteDataSource.getSearchedSeries(any())).thenAnswer(
          (_) async => tSeriesEntityList,
        );

        final result = await repo.getSearchedSeries('teste');

        expect(
          result,
          const Right<dynamic, List<SeriesModel>>(tSeriesEntityList),
        );
        verify(() => remoteDataSource.getSearchedSeries('teste')).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );
    test(
      'should return [Left<ServerFailure>] when the call is unsuccessful',
      () async {
        when(() => remoteDataSource.getSearchedSeries(any()))
            .thenThrow(tServerException);

        final result = await repo.getSearchedSeries('teste');

        expect(
          result,
          Left<Failure, dynamic>(
            ServerFailure.fromException(tServerException),
          ),
        );
        verify(() => remoteDataSource.getSearchedSeries('teste')).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );
  });
}
