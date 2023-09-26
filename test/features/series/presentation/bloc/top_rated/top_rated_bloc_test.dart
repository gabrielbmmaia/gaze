import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:gaze/core/errors/failures.dart';
import 'package:gaze/features/series/domain/models/series_model.dart';
import 'package:gaze/features/series/domain/usecases/get_top_rated_series.dart';
import 'package:gaze/features/series/presentation/bloc/top_rated/top_rated_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockGetTopRatedSeriesUseCase extends Mock
    implements GetTopRatedSeriesUseCase {}

void main() {
  late GetTopRatedSeriesUseCase topRatedSeries;
  late TopRatedBloc bloc;

  setUp(() {
    topRatedSeries = MockGetTopRatedSeriesUseCase();
    bloc = TopRatedBloc(getTopRatedSeries: topRatedSeries);
  });

  tearDown(() => bloc.close());

  test('initial state should be [TopRatedInitial]', () {
    expect(bloc.state, const TopRatedInitial());
  });

  const tSeriesList = [SeriesModel.empty()];
  final tServerFailure = ServerFailure(
    message: 'Test error failure',
    statusCode: '505',
  );

  group('topRatedSeries', () {
    blocTest<TopRatedBloc, TopRatedState>(
      'should emit [LoadingTopRatedSeries, LoadedTopRatedSeries] when '
      '[LoadTopRatedListEvent] is added',
      build: () {
        when(() => topRatedSeries()).thenAnswer(
          (_) async => const Right(tSeriesList),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(const LoadTopRatedListEvent()),
      expect: () => const <TopRatedState>[
        LoadingTopRatedSeries(),
        LoadedTopRatedSeries(topRatedList: tSeriesList),
      ],
      verify: (_) {
        verify(() => topRatedSeries()).called(1);
        verifyNoMoreInteractions(topRatedSeries);
      },
    );

    blocTest<TopRatedBloc, TopRatedState>(
      'should emit [LoadingTopRatedSeries, ErrorTopRatedSeries] when '
          '[LoadTopRatedListEvent] is added',
      build: () {
        when(() => topRatedSeries()).thenAnswer(
              (_) async => Left(tServerFailure),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(const LoadTopRatedListEvent()),
      expect: () => const <TopRatedState>[
        LoadingTopRatedSeries(),
        ErrorTopRatedSeries(),
      ],
      verify: (_) {
        verify(() => topRatedSeries()).called(1);
        verifyNoMoreInteractions(topRatedSeries);
      },
    );
  });
}
