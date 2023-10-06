import 'package:dartz/dartz.dart';
import 'package:gaze/features/auth/domain/repositories/auth_repo.dart';
import 'package:gaze/features/auth/domain/usecases/is_favorite_item.dart';
import 'package:gaze/features/series/domain/models/series_model.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'auth_repo.mock.dart';

void main() {
  late AuthRepo repo;
  late IsFavoriteItemUseCase useCase;

  setUp(() {
    repo = MockAuthRepo();
    useCase = IsFavoriteItemUseCase(repo);
    registerFallbackValue(const SeriesModel.empty());
  });

  test(
    'should call [AuthRepo.isFavoriteItem] and return [Right<bool>] when '
    'the call is successful',
    () async {
      when(() => repo.isFavoriteItem(item: any(named: 'item')))
          .thenAnswer((_) async => const Right(true));

      final result = await useCase(const SeriesModel.empty());

      expect(result, const Right<dynamic, bool>(true));
      verify(() => repo.isFavoriteItem(item: const SeriesModel.empty()))
          .called(1);
      verifyNoMoreInteractions(repo);
    },
  );
}
