import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:gaze/core/enums/networks.dart';
import 'package:gaze/core/errors/failures.dart';
import 'package:gaze/features/series/domain/models/series_model.dart';
import 'package:gaze/features/series/domain/usecases/get_network_series.dart';
import 'package:gaze/features/series/presentation/bloc/netflix/netflix_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../get_network_series.mock.dart';

void main() {
  late GetNetworkSeriesUseCase getNetworkSeries;
  late NetflixBloc bloc;

  setUp(() {
    getNetworkSeries = MockGetNetworkSeriesUseCase();
    bloc = NetflixBloc(getNetworkSeries: getNetworkSeries);
    registerFallbackValue(Networks.netflix);
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
        when(() => getNetworkSeries(any())).thenAnswer(
          (_) async => const Right(tSeriesList),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(const LoadNetflixListEvent(Networks.netflix)),
      expect: () => const <NetflixState>[
        LoadingNetflixSeries(),
        LoadedNetflixSeries(netflixList: tSeriesList),
      ],
      verify: (_) {
        verify(() => getNetworkSeries(Networks.netflix)).called(1);
        verifyNoMoreInteractions(getNetworkSeries);
      },
    );

    blocTest<NetflixBloc, NetflixState>(
      'should emit [LoadingNetflixSeries, ErrorNetflixSeries] when '
          '[LoadNetflixListEvent] is added',
      build: () {
        when(() => getNetworkSeries(any())).thenAnswer(
              (_) async => Left(tServerFailure),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(const LoadNetflixListEvent(Networks.netflix)),
      expect: () => const <NetflixState>[
        LoadingNetflixSeries(),
        ErrorNetflixSeries(),
      ],
      verify: (_) {
        verify(() => getNetworkSeries(Networks.netflix)).called(1);
        verifyNoMoreInteractions(getNetworkSeries);
      },
    );
  });
}
