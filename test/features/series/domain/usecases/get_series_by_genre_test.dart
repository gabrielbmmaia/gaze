import 'package:dartz/dartz.dart';
import 'package:gaze/core/enums/genres.dart';
import 'package:gaze/features/series/domain/models/series_model.dart';
import 'package:gaze/features/series/domain/repositories/series_repo.dart';
import 'package:gaze/features/series/domain/usecases/get_series_by_genre.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'series_repo.mock.dart';

void main() {
  late SeriesRepo repo;
  late GetSeriesByGenreUseCase useCase;

  setUp(() {
    repo = MockSeriesRepo();
    useCase = GetSeriesByGenreUseCase(repo);
    registerFallbackValue(Genres.animation);
  });

  const tSeriesList = [SeriesModel.empty()];

  test(
    'should call [SeriesRepo.getSeriesByGender] and return '
    '[Right<List<SeriesModel>>] when the call is successful',
    () async {
      when(() => repo.getSeriesByGenre(any())).thenAnswer(
        (_) async => const Right(tSeriesList),
      );

      final result = await useCase(Genres.animation);

      expect(result, const Right<dynamic, List<SeriesModel>>(tSeriesList));
      verify(() => repo.getSeriesByGenre(Genres.animation)).called(1);
      verifyNoMoreInteractions(repo);
    },
  );
}
