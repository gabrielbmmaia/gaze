import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:gaze/core/errors/failures.dart';
import 'package:gaze/features/series/domain/models/series_model.dart';
import 'package:gaze/features/series/domain/usecases/get_trending_series.dart';
import 'package:gaze/features/series/presentation/bloc/trending/trending_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockGetTrendingSeriesUseCase extends Mock
    implements GetTrendingSeriesUseCase {}

void main() {

  late GetTrendingSeriesUseCase getTrendingSeries;
  late TrendingBloc bloc;

  setUp(() {
    getTrendingSeries = MockGetTrendingSeriesUseCase();
    bloc = TrendingBloc(getTrendingSeries: getTrendingSeries);
  });

  tearDown(() => bloc.close());

  test('initial state must be [TrendingInitial]', () {
    expect(bloc.state, const TrendingInitial());
  });

  const tSeriesList = [SeriesModel.empty()];
  final tServerFailure = ServerFailure(
    message: 'Test error failure',
    statusCode: '505',
  );

  group('getTrendingSeries', () {
    blocTest<TrendingBloc, TrendingState>(
      'should emit [LoadingTrendingSeries, LoadedTrendingSeries] when '
          '[LoadTrendingListEvent] is added',
      build: () {
        when(() => getTrendingSeries())
            .thenAnswer((_) async => const Right(tSeriesList));
        return bloc;
      },
      act: (bloc) => bloc.add(const LoadTrendingListEvent()),
      expect: () => const <TrendingState>[
        LoadingTrendingSeries(),
        LoadedTrendingSeries(trendingList: tSeriesList),
      ],
      verify: (_) {
        verify(() => getTrendingSeries()).called(1);
        verifyNoMoreInteractions(getTrendingSeries);
      },
    );

    blocTest<TrendingBloc, TrendingState>(
      'should emit [LoadingTrendingSeries, ErrorTrendingSeries] when '
          '[LoadTrendingListEvent] is added',
      build: () {
        when(() => getTrendingSeries())
            .thenAnswer((_) async => Left(tServerFailure));
        return bloc;
      },
      act: (bloc) => bloc.add(const LoadTrendingListEvent()),
      expect: () => const <TrendingState>[
        LoadingTrendingSeries(),
        ErrorTrendingSeries(),
      ],
      verify: (_) {
        verify(() => getTrendingSeries()).called(1);
        verifyNoMoreInteractions(getTrendingSeries);
      },
    );
  });
}