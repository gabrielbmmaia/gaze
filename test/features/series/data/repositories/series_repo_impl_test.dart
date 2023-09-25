import 'package:dartz/dartz.dart';
import 'package:gaze/core/errors/exceptions.dart';
import 'package:gaze/core/errors/failures.dart';
import 'package:gaze/features/series/data/data_sources/series_remote_data_source.dart';
import 'package:gaze/features/series/data/models/series_entity.dart';
import 'package:gaze/features/series/data/repositories/series_repo_impl.dart';
import 'package:gaze/features/series/domain/models/series_model.dart';
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
  });

  const tSeriesEntityList = [SeriesEntity.empty()];
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
}
