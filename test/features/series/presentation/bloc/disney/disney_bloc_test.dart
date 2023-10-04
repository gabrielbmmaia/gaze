import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:gaze/core/enums/networks.dart';
import 'package:gaze/core/errors/failures.dart';
import 'package:gaze/features/series/domain/models/series_model.dart';
import 'package:gaze/features/series/domain/usecases/get_network_series.dart';
import 'package:gaze/features/series/presentation/bloc/disney/disney_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../get_network_series.mock.dart';

void main() {
  late GetNetworkSeriesUseCase getNetworkSeries;
  late DisneyBloc bloc;

  setUp(() {
    getNetworkSeries = MockGetNetworkSeriesUseCase();
    bloc = DisneyBloc(getNetworkSeries: getNetworkSeries);
    registerFallbackValue(Networks.disney);
  });

  tearDown(() => bloc.close());

  test('initial state should be [DisneyInitial]', () {
    expect(bloc.state, const DisneyInitial());
  });

  const tSeriesList = [SeriesModel.empty()];
  final tServerFailure = ServerFailure(
    message: 'Test error failure',
    statusCode: '505',
  );

  group('disneyBloc', () {
    blocTest<DisneyBloc, DisneyState>(
      'should emit [LoadingDisneySeries, LoadedDisneySeries] when '
      '[LoadDisneyListEvent] is added',
      build: () {
        when(() => getNetworkSeries(any()))
            .thenAnswer((_) async => const Right(tSeriesList));
        return bloc;
      },
      act: (bloc) => bloc.add(const LoadDisneyListEvent(Networks.disney)),
      expect: () => const <DisneyState>[
        LoadingDisneySeries(),
        LoadedDisneySeries(disneyList: tSeriesList),
      ],
      verify: (_) {
        verify(() => getNetworkSeries(Networks.disney)).called(1);
        verifyNoMoreInteractions(getNetworkSeries);
      },
    );
    blocTest<DisneyBloc, DisneyState>(
      'should emit [LoadingDisneySeries, ErrorDisneySeries] when '
      '[LoadDisneyListEvent] is added',
      build: () {
        when(() => getNetworkSeries(any()))
            .thenAnswer((_) async => Left(tServerFailure));
        return bloc;
      },
      act: (bloc) => bloc.add(const LoadDisneyListEvent(Networks.disney)),
      expect: () => const <DisneyState>[
        LoadingDisneySeries(),
        ErrorDisneySeries(),
      ],
      verify: (_) {
        verify(() => getNetworkSeries(Networks.disney)).called(1);
        verifyNoMoreInteractions(getNetworkSeries);
      },
    );
  });
}
