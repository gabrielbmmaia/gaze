import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:gaze/core/errors/failures.dart';
import 'package:gaze/features/series/domain/models/series_model.dart';
import 'package:gaze/features/series/domain/usecases/get_popular_series.dart';
import 'package:gaze/features/series/presentation/bloc/series_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockGetPopularSeriesUseCase extends Mock
    implements GetPopularSeriesUseCase {}

void main() {
  late GetPopularSeriesUseCase useCase;
  late SeriesBloc bloc;

  setUp(() {
    useCase = MockGetPopularSeriesUseCase();
    bloc = SeriesBloc(getPopularSeries: useCase);
  });

  tearDown(() => bloc.close());

  test('initial state must be [SeriesInitial]', () {
    expect(bloc.state, const SeriesInitial());
  });

  const tSeriesList = [SeriesModel.empty()];
  final tServerFailure = ServerFailure(
    message: 'Test error failure',
    statusCode: '505',
  );

  group('getPopularSeries', () {
    blocTest<SeriesBloc, SeriesState>(
      'should emit [LoadingPopularSeries, LoadedPopularSeries] when '
      '[LoadPopularListEvent] is added',
      build: () {
        when(() => useCase()).thenAnswer((_) async => const Right(tSeriesList));
        return bloc;
      },
      act: (bloc) => bloc.add(const LoadPopularListEvent()),
      expect: () => const <SeriesState>[
        LoadingPopularSeries(),
        LoadedPopularSeries(popularList: tSeriesList),
      ],
      verify: (_) {
        verify(() => useCase()).called(1);
        verifyNoMoreInteractions(useCase);
      },
    );

    blocTest<SeriesBloc, SeriesState>(
      'TODO: description',
      build: () {
        when(() => useCase()).thenAnswer((_) async => Left(tServerFailure));
        return bloc;
      },
      act: (bloc) => bloc.add(const LoadPopularListEvent()),
      expect: () => const <SeriesState>[
        LoadingPopularSeries(),
        ErrorPopularSeries(),
      ],
      verify: (_) {
        verify(() => useCase()).called(1);
        verifyNoMoreInteractions(useCase);
      },
    );
  });
}
