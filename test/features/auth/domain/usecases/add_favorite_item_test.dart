import 'package:dartz/dartz.dart';
import 'package:gaze/features/auth/domain/repositories/auth_repo.dart';
import 'package:gaze/features/auth/domain/usecases/add_favorite_item.dart';
import 'package:gaze/features/series/domain/models/series_model.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'auth_repo.mock.dart';

void main() {
  late AuthRepo repo;
  late AddFavoriteItemUseCase useCase;

  setUp(() {
    repo = MockAuthRepo();
    useCase = AddFavoriteItemUseCase(repo);
    registerFallbackValue(const SeriesModel.empty());
  });

  test(
    'should call [AuthRepo.addFavoriteItem] and return [Right<null>] '
    'when the call is successful',
    () async {
      when(() => repo.addFavoriteItem(item: any(named: 'item')))
          .thenAnswer((_) async => const Right(null));

      final result = await useCase(const SeriesModel.empty());

      expect(result, const Right<dynamic, void>(null));
      verify(() => repo.addFavoriteItem(item: const SeriesModel.empty()))
          .called(1);
      verifyNoMoreInteractions(repo);
    },
  );
}
