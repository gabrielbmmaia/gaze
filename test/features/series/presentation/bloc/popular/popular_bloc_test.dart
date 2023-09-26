import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:gaze/core/errors/failures.dart';
import 'package:gaze/features/series/domain/models/series_model.dart';
import 'package:gaze/features/series/domain/usecases/get_popular_series.dart';
import 'package:gaze/features/series/presentation/bloc/popular/popular_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockGetPopularSeriesUseCase extends Mock
    implements GetPopularSeriesUseCase {}

void main() {
  late GetPopularSeriesUseCase popularSeries;
  late PopularBloc bloc;

  setUp(() {
    popularSeries = MockGetPopularSeriesUseCase();
    bloc = PopularBloc(getPopularSeries: popularSeries);
  });

  tearDown(() => bloc.close());

  test('initial state must be [PopularInitial]', () {
    expect(bloc.state, const PopularInitial());
  });

  const tSeriesList = [SeriesModel.empty()];
  final tServerFailure = ServerFailure(
    message: 'Test error failure',
    statusCode: '505',
  );

  group('getPopularSeries', () {
    blocTest<PopularBloc, PopularState>(
      'should emit [LoadingPopularSeries, LoadedPopularSeries] when '
      '[LoadPopularListEvent] is added',
      build: () {
        when(() => popularSeries())
            .thenAnswer((_) async => const Right(tSeriesList));
        return bloc;
      },
      act: (bloc) => bloc.add(const LoadPopularListEvent()),
      expect: () => const <PopularState>[
        LoadingPopularSeries(),
        LoadedPopularSeries(popularList: tSeriesList),
      ],
      verify: (_) {
        verify(() => popularSeries()).called(1);
        verifyNoMoreInteractions(popularSeries);
      },
    );

    blocTest<PopularBloc, PopularState>(
      'should emit [LoadingPopularSeries, ErrorPopularSeries] when '
      '[LoadPopularListEvent] is added',
      build: () {
        when(() => popularSeries())
            .thenAnswer((_) async => Left(tServerFailure));
        return bloc;
      },
      act: (bloc) => bloc.add(const LoadPopularListEvent()),
      expect: () => const <PopularState>[
        LoadingPopularSeries(),
        ErrorPopularSeries(),
      ],
      verify: (_) {
        verify(() => popularSeries()).called(1);
        verifyNoMoreInteractions(popularSeries);
      },
    );
  });
}
