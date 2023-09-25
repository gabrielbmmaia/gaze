import 'package:dartz/dartz.dart';
import 'package:gaze/features/series/domain/models/series_model.dart';
import 'package:gaze/features/series/domain/repositories/series_repo.dart';
import 'package:gaze/features/series/domain/usecases/get_trending_series.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'series_repo.mock.dart';

void main() {
  late SeriesRepo repo;
  late GetTrendingSeriesUseCase useCase;

  setUp(() {
    repo = MockSeriesRepo();
    useCase = GetTrendingSeriesUseCase(repo);
  });

  const tSeriesList = [SeriesModel.empty()];
  test(
    'should call [SeriesRepo.getTrendingSeries] and return [List<SeriesModel>] '
    'when the call is successful',
    () async {
      when(() => repo.getTrendingSeries())
          .thenAnswer((_) async => const Right(tSeriesList));

      final result = await useCase();

      expect(result, const Right<dynamic, List<SeriesModel>>(tSeriesList));
      verify(() => repo.getTrendingSeries()).called(1);
      verifyNoMoreInteractions(repo);
    },
  );
}
