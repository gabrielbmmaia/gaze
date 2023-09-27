import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:gaze/core/errors/failures.dart';
import 'package:gaze/features/series/domain/models/series_model.dart';
import 'package:gaze/features/series/domain/usecases/get_amazon_series.dart';
import 'package:gaze/features/series/presentation/bloc/amazon/amazon_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockGetAmazonSeriesUseCase extends Mock
    implements GetAmazonSeriesUseCase {}

void main() {
  late GetAmazonSeriesUseCase amazonSeries;
  late AmazonBloc bloc;

  setUp(() {
    amazonSeries = MockGetAmazonSeriesUseCase();
    bloc = AmazonBloc(getAmazonSeries: amazonSeries);
  });

  tearDown(() => bloc.close());

  test('initial state should be [AmazonInitial]', () {
    expect(bloc.state, const AmazonInitial());
  });

  const tSeriesList = [SeriesModel.empty()];
  final tServerFailure = ServerFailure(
    message: 'Test error failure',
    statusCode: '505',
  );

  group('amazonSeries', () {
    blocTest<AmazonBloc, AmazonState>(
      'should emit [LoadingAmazonSeries, LoadedAmazonSeries] when '
          '[LoadAmazonListEvent] is added',
      build: () {
        when(() => amazonSeries()).thenAnswer(
              (_) async => const Right(tSeriesList),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(const LoadAmazonListEvent()),
      expect: () => const <AmazonState>[
        LoadingAmazonSeries(),
        LoadedAmazonSeries(amazonList: tSeriesList),
      ],
      verify: (_) {
        verify(() => amazonSeries()).called(1);
        verifyNoMoreInteractions(amazonSeries);
      },
    );

    blocTest<AmazonBloc, AmazonState>(
      'should emit [LoadingAmazonSeries, ErrorAmazonSeries] when '
          '[LoadAmazonListEvent] is added',
      build: () {
        when(() => amazonSeries()).thenAnswer(
              (_) async => Left(tServerFailure),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(const LoadAmazonListEvent()),
      expect: () => const <AmazonState>[
        LoadingAmazonSeries(),
        ErrorAmazonSeries(),
      ],
      verify: (_) {
        verify(() => amazonSeries()).called(1);
        verifyNoMoreInteractions(amazonSeries);
      },
    );
  });
}
