import 'package:dartz/dartz.dart';
import 'package:gaze/features/series/domain/models/series_model.dart';
import 'package:gaze/features/series/domain/repositories/series_repo.dart';
import 'package:gaze/features/series/domain/usecases/get_apple_series.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'series_repo.mock.dart';

void main() {
  late SeriesRepo repo;
  late GetAppleSeriesUseCase useCase;

  setUp(() {
    repo = MockSeriesRepo();
    useCase = GetAppleSeriesUseCase(repo);
  });

  const tSeriesList = [SeriesModel.empty()];

  test(
    'should call [SeriesRepo.getAppleSeries] and return '
    '[Right<List<SeriesModel>>] when the call is successful',
    () async {
      when(() => repo.getAppleSeries()).thenAnswer(
        (_) async => const Right(tSeriesList),
      );

      final result = await useCase();

      expect(result, const Right<dynamic, List<SeriesModel>>(tSeriesList));
      verify(() => repo.getAppleSeries()).called(1);
      verifyNoMoreInteractions(repo);
    },
  );
}
