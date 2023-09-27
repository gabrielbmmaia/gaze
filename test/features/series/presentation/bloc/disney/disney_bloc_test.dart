import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:gaze/core/errors/failures.dart';
import 'package:gaze/features/series/domain/models/series_model.dart';
import 'package:gaze/features/series/domain/usecases/get_disney_series.dart';
import 'package:gaze/features/series/presentation/bloc/disney/disney_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockGetDisneySeriesUseCase extends Mock
    implements GetDisneySeriesUseCase {}

void main() {
  late GetDisneySeriesUseCase getDisneySeries;
  late DisneyBloc bloc;

  setUp(() {
    getDisneySeries = MockGetDisneySeriesUseCase();
    bloc = DisneyBloc(getDisneySeries: getDisneySeries);
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
        when(() => getDisneySeries())
            .thenAnswer((_) async => const Right(tSeriesList));
        return bloc;
      },
      act: (bloc) => bloc.add(const LoadDisneyListEvent()),
      expect: () => const <DisneyState>[
        LoadingDisneySeries(),
        LoadedDisneySeries(disneyList: tSeriesList),
      ],
      verify: (_) {
        verify(() => getDisneySeries()).called(1);
        verifyNoMoreInteractions(getDisneySeries);
      },
    );
    blocTest<DisneyBloc, DisneyState>(
      'should emit [LoadingDisneySeries, ErrorDisneySeries] when '
          '[LoadDisneyListEvent] is added',
      build: () {
        when(() => getDisneySeries())
            .thenAnswer((_) async => Left(tServerFailure));
        return bloc;
      },
      act: (bloc) => bloc.add(const LoadDisneyListEvent()),
      expect: () => const <DisneyState>[
        LoadingDisneySeries(),
        ErrorDisneySeries(),
      ],
      verify: (_) {
        verify(() => getDisneySeries()).called(1);
        verifyNoMoreInteractions(getDisneySeries);
      },
    );
  });
}
