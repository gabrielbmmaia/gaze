import 'package:dartz/dartz.dart';
import 'package:gaze/features/series/domain/repositories/series_repo.dart';
import 'package:gaze/features/series/domain/usecases/get_series_classification.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'series_repo.mock.dart';

void main() {
  late SeriesRepo repo;
  late GetSeriesClassificationUseCase useCase;

  setUp(() {
    repo = MockSeriesRepo();
    useCase = GetSeriesClassificationUseCase(repo);
  });

  test(
    'should call [SeriesRepo.getSeriesClassification] and return '
    '[int?] when the call is successful',
    () async {
      when(() => repo.getSeriesClassification(any())).thenAnswer(
        (_) async => const Right('14'),
      );

      final result = await useCase('123456');

      expect(result, const Right<dynamic, String?>('14'));
      verify(() => repo.getSeriesClassification('123456')).called(1);
      verifyNoMoreInteractions(repo);
    },
  );
}
