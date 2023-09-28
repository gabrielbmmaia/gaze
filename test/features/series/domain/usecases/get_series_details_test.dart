import 'package:dartz/dartz.dart';
import 'package:gaze/features/series/domain/models/series_details_model.dart';
import 'package:gaze/features/series/domain/repositories/series_repo.dart';
import 'package:gaze/features/series/domain/usecases/get_series_details.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'series_repo.mock.dart';

void main() {
  late SeriesRepo repo;
  late GetSeriesDetailsUseCase useCase;

  setUp(() {
    repo = MockSeriesRepo();
    useCase = GetSeriesDetailsUseCase(repo);
  });

  final tSeriesDetails = SeriesDetailsModel.empty();

  test(
    'should call [SeriesRepo.getSeriesDetails] and return '
    '[Right<SeriesDetailsModel>] when the call is successful',
    () async {
      when(() => repo.getSeriesDetails(any())).thenAnswer(
        (_) async => Right(tSeriesDetails),
      );

      final result = await useCase('123456');

      expect(result, Right<dynamic, SeriesDetailsModel>(tSeriesDetails));
      verify(() => repo.getSeriesDetails('123456')).called(1);
      verifyNoMoreInteractions(repo);
    },
  );
}
