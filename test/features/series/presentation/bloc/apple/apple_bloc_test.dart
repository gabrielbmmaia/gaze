import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:gaze/core/enums/networks.dart';
import 'package:gaze/core/errors/failures.dart';
import 'package:gaze/features/series/domain/models/series_model.dart';
import 'package:gaze/features/series/domain/usecases/get_network_series.dart';
import 'package:gaze/features/series/presentation/bloc/apple/apple_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../get_network_series.mock.dart';

void main() {
  late GetNetworkSeriesUseCase getNetworkSeries;
  late AppleBloc bloc;

  setUp(() {
    getNetworkSeries = MockGetNetworkSeriesUseCase();
    bloc = AppleBloc(getNetworkSeries: getNetworkSeries);
    registerFallbackValue(Networks.apple);
  });

  tearDown(() => bloc.close());

  test('initial state should be [AppleInitial]', () {
    expect(bloc.state, const AppleInitial());
  });

  const tSeriesList = [SeriesModel.empty()];
  final tServerFailure = ServerFailure(
    message: 'Test error failure',
    statusCode: '505',
  );

  group('appleBloc', () {
    blocTest<AppleBloc, AppleState>(
      'should emit [LoadingAppleSeries, LoadedAppleSeries] when '
      '[LoadAppleListEvent] is added',
      build: () {
        when(() => getNetworkSeries(any())).thenAnswer(
          (_) async => const Right(tSeriesList),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(const LoadAppleListEvent(Networks.apple)),
      expect: () => const <AppleState>[
        LoadingAppleSeries(),
        LoadedAppleSeries(appleList: tSeriesList),
      ],
      verify: (_) {
        verify(() => getNetworkSeries(Networks.apple)).called(1);
        verifyNoMoreInteractions(getNetworkSeries);
      },
    );

    blocTest<AppleBloc, AppleState>(
      'should emit [LoadingAppleSeries, ErrorAppleSeries] when '
      '[LoadAppleListEvent] is added',
      build: () {
        when(() => getNetworkSeries(any())).thenAnswer(
          (_) async => Left(tServerFailure),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(const LoadAppleListEvent(Networks.apple)),
      expect: () => const <AppleState>[
        LoadingAppleSeries(),
        ErrorAppleSeries(),
      ],
      verify: (_) {
        verify(() => getNetworkSeries(Networks.apple)).called(1);
        verifyNoMoreInteractions(getNetworkSeries);
      },
    );
  });
}
