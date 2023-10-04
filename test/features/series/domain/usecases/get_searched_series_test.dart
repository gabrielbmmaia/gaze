import 'package:dartz/dartz.dart';
import 'package:gaze/features/series/domain/models/series_model.dart';
import 'package:gaze/features/series/domain/repositories/series_repo.dart';
import 'package:gaze/features/series/domain/usecases/get_searched_series.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'series_repo.mock.dart';

void main() {
  late SeriesRepo repo;
  late GetSearchedSeriesUseCase useCase;

  setUp(() {
    repo = MockSeriesRepo();
    useCase = GetSearchedSeriesUseCase(repo);
  });

  const tSeriesList = [SeriesModel.empty()];

  test(
    'should call [SeriesRepo.getSearchedSeries] and return '
    '[Right<List<SeriesModel>>] when the call is successful',
    () async {
      when(() => repo.getSearchedSeries(any())).thenAnswer(
        (_) async => const Right(tSeriesList),
      );

      final result = await useCase('teste');

      expect(result, const Right<dynamic, List<SeriesModel>>(tSeriesList));
      verify(() => repo.getSearchedSeries('teste'));
      verifyNoMoreInteractions(repo);
    },
  );
}
