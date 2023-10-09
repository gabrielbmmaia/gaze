import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:gaze/core/errors/failures.dart';
import 'package:gaze/features/series/domain/models/series_details_model.dart';
import 'package:gaze/features/series/domain/usecases/get_series_details.dart';
import 'package:gaze/features/series/presentation/bloc/series_details/series_details_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockGetSeriesDetailsUseCase extends Mock
    implements GetSeriesDetailsUseCase {}

void main() {
  late GetSeriesDetailsUseCase getSeriesDetails;
  late SeriesDetailsBloc bloc;

  setUp(() {
    getSeriesDetails = MockGetSeriesDetailsUseCase();
    bloc = SeriesDetailsBloc(getSeriesDetails: getSeriesDetails);
  });

  tearDown(() => bloc.close());

  test('initial state should be [SeriesDetailsInitial]', () {
    expect(bloc.state, const SeriesDetailsInitial());
  });

  final tSeriesDetails = SeriesDetailsModel.empty();
  final tServerFailure = ServerFailure(
    message: 'Test error failure',
    statusCode: '505',
  );

  group('seriesDetailsBloc', () {
    blocTest<SeriesDetailsBloc, SeriesDetailsState>(
      'should emit [LoadingSeriesDetails, LoadedSeriesDetails] when '
      '[LoadTopRatedListEvent] is added',
      build: () {
        when(() => getSeriesDetails(any()))
            .thenAnswer((_) async => Right(tSeriesDetails));
        return bloc;
      },
      act: (bloc) => bloc.add(const LoadSeriesDetailsEvent(seriesId: '123456')),
      expect: () => <SeriesDetailsState>[
        const LoadingSeriesDetails(),
        LoadedSeriesDetails(seriesDetails: tSeriesDetails),
      ],
      verify: (_) {
        verify(() => getSeriesDetails('123456')).called(1);
        verifyNoMoreInteractions(getSeriesDetails);
      },
    );
    blocTest<SeriesDetailsBloc, SeriesDetailsState>(
      'should emit [LoadingSeriesDetails, ErrorSeriesDetails] when '
      '[LoadTopRatedListEvent] is added',
      build: () {
        when(() => getSeriesDetails(any()))
            .thenAnswer((_) async => Left(tServerFailure));
        return bloc;
      },
      act: (bloc) => bloc.add(const LoadSeriesDetailsEvent(seriesId: '123456')),
      expect: () => <SeriesDetailsState>[
        const LoadingSeriesDetails(),
        ErrorSeriesDetails(errorMessage: tServerFailure.message),
      ],
      verify: (_) {
        verify(() => getSeriesDetails('123456')).called(1);
        verifyNoMoreInteractions(getSeriesDetails);
      },
    );
  });
}
