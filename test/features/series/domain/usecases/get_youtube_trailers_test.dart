import 'package:dartz/dartz.dart';
import 'package:gaze/features/series/domain/models/youtube_trailers_model.dart';
import 'package:gaze/features/series/domain/repositories/series_repo.dart';
import 'package:gaze/features/series/domain/usecases/get_youtube_trailers.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'series_repo.mock.dart';

void main() {
  late SeriesRepo repo;
  late GetYoutubeTrailersUseCase useCase;

  setUp(() {
    repo = MockSeriesRepo();
    useCase = GetYoutubeTrailersUseCase(repo);
  });

  const tTrailersList = [YoutubeTrailersModel.empty()];

  test(
    'should call [SeriesRepo.getYoutubeTrailers] and return '
    '[Right<List<YoutubeTrailersModel>>] when the call is successful',
    () async {
      when(() => repo.getYoutubeTrailers(any())).thenAnswer(
        (_) async => const Right(tTrailersList),
      );

      final result = await useCase('123456');

      expect(
        result,
        const Right<dynamic, List<YoutubeTrailersModel>>(tTrailersList),
      );
      verify(() => repo.getYoutubeTrailers('123456')).called(1);
      verifyNoMoreInteractions(repo);
    },
  );
}
