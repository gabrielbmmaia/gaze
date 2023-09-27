import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:gaze/core/errors/failures.dart';
import 'package:gaze/features/series/domain/models/series_model.dart';
import 'package:gaze/features/series/domain/usecases/get_apple_series.dart';
import 'package:gaze/features/series/presentation/bloc/apple/apple_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockGetAppleSeriesUseCase extends Mock implements GetAppleSeriesUseCase {}

void main() {
  late GetAppleSeriesUseCase getAppleSeries;
  late AppleBloc bloc;

  setUp(() {
    getAppleSeries = MockGetAppleSeriesUseCase();
    bloc = AppleBloc(getAppleSeries: getAppleSeries);
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
        when(() => getAppleSeries()).thenAnswer(
          (_) async => const Right(tSeriesList),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(const LoadAppleListEvent()),
      expect: () => const <AppleState>[
        LoadingAppleSeries(),
        LoadedAppleSeries(appleList: tSeriesList),
      ],
      verify: (_) {
        verify(() => getAppleSeries()).called(1);
        verifyNoMoreInteractions(getAppleSeries);
      },
    );

    blocTest<AppleBloc, AppleState>(
      'should emit [LoadingAppleSeries, ErrorAppleSeries] when '
      '[LoadAppleListEvent] is added',
      build: () {
        when(() => getAppleSeries()).thenAnswer(
          (_) async => Left(tServerFailure),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(const LoadAppleListEvent()),
      expect: () => const <AppleState>[
        LoadingAppleSeries(),
        ErrorAppleSeries(),
      ],
      verify: (_) {
        verify(() => getAppleSeries()).called(1);
        verifyNoMoreInteractions(getAppleSeries);
      },
    );
  });
}
