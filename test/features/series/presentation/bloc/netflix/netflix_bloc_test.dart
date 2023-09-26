import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:gaze/core/errors/failures.dart';
import 'package:gaze/features/series/domain/models/series_model.dart';
import 'package:gaze/features/series/domain/usecases/get_netflix_series.dart';
import 'package:gaze/features/series/presentation/bloc/netflix/netflix_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockGetNetflixSeriesUseCase extends Mock
    implements GetNetflixSeriesUseCase {}

void main() {
  late GetNetflixSeriesUseCase netflixSeries;
  late NetflixBloc bloc;

  setUp(() {
    netflixSeries = MockGetNetflixSeriesUseCase();
    bloc = NetflixBloc(getNetflixSeries: netflixSeries);
  });

  tearDown(() => bloc.close());

  test('initial state should be [NetflixInitial]', () {
    expect(bloc.state, const NetflixInitial());
  });

  const tSeriesList = [SeriesModel.empty()];
  final tServerFailure = ServerFailure(
    message: 'Test error failure',
    statusCode: '505',
  );

  group('netflixSeries', () {
    blocTest<NetflixBloc, NetflixState>(
      'should emit [LoadingNetflixSeries, LoadedNetflixSeries] when '
      '[LoadNetflixListEvent] is added',
      build: () {
        when(() => netflixSeries()).thenAnswer(
          (_) async => const Right(tSeriesList),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(const LoadNetflixListEvent()),
      expect: () => const <NetflixState>[
        LoadingNetflixSeries(),
        LoadedNetflixSeries(netflixList: tSeriesList),
      ],
      verify: (_) {
        verify(() => netflixSeries()).called(1);
        verifyNoMoreInteractions(netflixSeries);
      },
    );

    blocTest<NetflixBloc, NetflixState>(
      'should emit [LoadingNetflixSeries, ErrorNetflixSeries] when '
          '[LoadNetflixListEvent] is added',
      build: () {
        when(() => netflixSeries()).thenAnswer(
              (_) async => Left(tServerFailure),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(const LoadNetflixListEvent()),
      expect: () => const <NetflixState>[
        LoadingNetflixSeries(),
        ErrorNetflixSeries(),
      ],
      verify: (_) {
        verify(() => netflixSeries()).called(1);
        verifyNoMoreInteractions(netflixSeries);
      },
    );
  });
}
