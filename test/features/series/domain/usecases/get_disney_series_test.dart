import 'package:dartz/dartz.dart';
import 'package:gaze/features/series/domain/models/series_model.dart';
import 'package:gaze/features/series/domain/repositories/series_repo.dart';
import 'package:gaze/features/series/domain/usecases/get_disney_series.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'series_repo.mock.dart';

void main() {
  late SeriesRepo repo;
  late GetDisneySeriesUseCase useCase;

  setUp(() {
    repo = MockSeriesRepo();
    useCase = GetDisneySeriesUseCase(repo);
  });

  const tSeriesList = [SeriesModel.empty()];

  test(
    'should call [SeriesRepo.getDisneySeries] and return '
    '[Right<List<SeriesModel>] when the call is successful',
    () async {
      when(() => repo.getDisneySeries()).thenAnswer(
        (_) async => const Right(tSeriesList),
      );

      final result = await useCase();

      expect(result, const Right<dynamic, List<SeriesModel>>(tSeriesList));
      verify(() => repo.getDisneySeries()).called(1);
      verifyNoMoreInteractions(repo);
    },
  );
}
