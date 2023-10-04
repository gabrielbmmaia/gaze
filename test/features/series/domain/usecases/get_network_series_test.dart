import 'package:dartz/dartz.dart';
import 'package:gaze/core/enums/networks.dart';
import 'package:gaze/features/series/domain/models/series_model.dart';
import 'package:gaze/features/series/domain/repositories/series_repo.dart';
import 'package:gaze/features/series/domain/usecases/get_network_series.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'series_repo.mock.dart';

void main() {
  late SeriesRepo repo;
  late GetNetworkSeriesUseCase useCase;

  setUp(() {
    repo = MockSeriesRepo();
    useCase = GetNetworkSeriesUseCase(repo);
    registerFallbackValue(Networks.netflix);
  });

  const tSeriesList = [SeriesModel.empty()];

  test(
    'should call [SeriesRepo.getNetworkSeries] and return '
    '[Right<List<SeriesModel>>] when the call is successful',
    () async {
      when(() => repo.getNetworkSeries(any())).thenAnswer(
        (_) async => const Right(tSeriesList),
      );

      final result = await useCase(Networks.netflix);

      expect(result, const Right<dynamic, List<SeriesModel>>(tSeriesList));
      verify(() => repo.getNetworkSeries(Networks.netflix)).called(1);
      verifyNoMoreInteractions(repo);
    },
  );
}
