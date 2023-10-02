import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:gaze/core/errors/failures.dart';
import 'package:gaze/features/series/domain/usecases/get_series_classification.dart';
import 'package:gaze/features/series/presentation/bloc/classification/classification_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockGetSeriesClassificationUseCase extends Mock
    implements GetSeriesClassificationUseCase {}

void main() {
  late GetSeriesClassificationUseCase getSeriesClassification;
  late ClassificationBloc bloc;

  setUp(() {
    getSeriesClassification = MockGetSeriesClassificationUseCase();
    bloc = ClassificationBloc(getSeriesClassification: getSeriesClassification);
  });

  tearDown(() => bloc.close());

  test('initial state should be [ClassificationInitial]', () {
    expect(bloc.state, const ClassificationInitial());
  });

  final tServerFailure = ServerFailure(
    message: 'Test error failure',
    statusCode: '505',
  );

  group('classificationBloc', () {
    blocTest<ClassificationBloc, ClassificationState>(
      'should emit [LoadingClassification, LoadedClassification] when '
          '[LoadClassificationEvent] is added',
      build: () {
        when(() => getSeriesClassification(any()))
            .thenAnswer((_) async => const Right('14'));
        return bloc;
      },
      act: (bloc) =>
          bloc.add(
            const LoadClassificationEvent(seriesId: '123456'),
          ),
      expect: () =>
      const <ClassificationState>[
      LoadingClassification(),
      LoadedClassification(classification: '14'),
      ],
      verify: (_) {
        verify(() => getSeriesClassification('123456')).called(1);
        verifyNoMoreInteractions(getSeriesClassification);
      },
    );
    blocTest<ClassificationBloc, ClassificationState>(
      'should emit [LoadingClassification, ErrorClassification] when '
          '[LoadClassificationEvent] is added',
      build: () {
        when(() => getSeriesClassification(any()))
            .thenAnswer((_) async => Left(tServerFailure));
        return bloc;
      },
      act: (bloc) =>
          bloc.add(
            const LoadClassificationEvent(seriesId: '123456'),
          ),
      expect: () =>
      const <ClassificationState>[
        LoadingClassification(),
        ErrorClassification(),
      ],
      verify: (_) {
        verify(() => getSeriesClassification('123456')).called(1);
        verifyNoMoreInteractions(getSeriesClassification);
      },
    );
  });
}
