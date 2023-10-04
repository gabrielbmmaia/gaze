import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:gaze/core/errors/failures.dart';
import 'package:gaze/features/series/domain/models/series_model.dart';
import 'package:gaze/features/series/domain/usecases/get_series_by_genre.dart';
import 'package:gaze/features/series/presentation/bloc/genre/genre_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockGetSeriesByGenresUseCase extends Mock
    implements GetSeriesByGenreUseCase {}

void main() {
  late GetSeriesByGenreUseCase getSeriesByGenre;
  late GenreBloc bloc;

  setUp(() {
    getSeriesByGenre = MockGetSeriesByGenresUseCase();
    bloc = GenreBloc(getSeriesByGenre: getSeriesByGenre);
  });

  tearDown(() => bloc.close());

  const tSeriesList = [SeriesModel.empty()];
  final tServerFailure = ServerFailure(
    message: 'Test error failure',
    statusCode: '505',
  );

  test('initial state should be [GenreInitial]', () {
    expect(bloc.state, const GenreInitial());
  });

  group('genreBloc', () {
    blocTest<GenreBloc, GenreState>(
      'should emit [LoadingGenreList, LoadedGenreList] when '
      '[LoadGenreListEvent] is added',
      build: () {
        when(() => getSeriesByGenre(any())).thenAnswer(
          (_) async => const Right(tSeriesList),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(const LoadGenreListEvent(genreId: '123456')),
      expect: () => const <GenreState>[
        LoadingGenreList(),
        LoadedGenreList(genreList: tSeriesList),
      ],
      verify: (_) {
        verify(() => getSeriesByGenre('123456')).called(1);
        verifyNoMoreInteractions(getSeriesByGenre);
      },
    );
    blocTest<GenreBloc, GenreState>(
      'should emit [LoadingGenreList, ErrorGenreList] when '
          '[LoadGenreListEvent] is added',
      build: () {
        when(() => getSeriesByGenre(any())).thenAnswer(
              (_) async => Left(tServerFailure),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(const LoadGenreListEvent(genreId: '123456')),
      expect: () => const <GenreState>[
        LoadingGenreList(),
        ErrorGenreList(),
      ],
      verify: (_) {
        verify(() => getSeriesByGenre('123456')).called(1);
        verifyNoMoreInteractions(getSeriesByGenre);
      },
    );
  });
}
