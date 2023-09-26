import 'package:dartz/dartz.dart';
import 'package:gaze/features/series/domain/models/series_model.dart';
import 'package:gaze/features/series/domain/repositories/series_repo.dart';
import 'package:gaze/features/series/domain/usecases/get_top_rated_series.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'series_repo.mock.dart';

void main() {
  late SeriesRepo repo;
  late GetTopRatedSeriesUseCase useCase;

  setUp(() {
    repo = MockSeriesRepo();
    useCase = GetTopRatedSeriesUseCase(repo);
  });

  const tSeriesList = [SeriesModel.empty()];

  test(
    'should call [SeriesRepo.getTopRatedSeries] and return '
    '[Right<List<SeriesModel>>] when the call is successful',
    () async {
      when(() => repo.getTopRatedSeries()).thenAnswer(
        (_) async => const Right(tSeriesList),
      );

      final result = await useCase();

      expect(result, isA<Right<dynamic, List<SeriesModel>>>());
      verify(() => repo.getTopRatedSeries()).called(1);
      verifyNoMoreInteractions(repo);
    },
  );
}
