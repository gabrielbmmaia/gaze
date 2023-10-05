import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:gaze/core/enums/genres.dart';
import 'package:gaze/core/enums/networks.dart';
import 'package:gaze/core/errors/failures.dart';
import 'package:gaze/features/series/domain/models/series_model.dart';
import 'package:gaze/features/series/domain/usecases/get_network_series.dart';
import 'package:gaze/features/series/domain/usecases/get_searched_series.dart';
import 'package:gaze/features/series/domain/usecases/get_series_by_genre.dart';
import 'package:gaze/features/series/presentation/bloc/searched/series_list_bloc.dart';
import 'package:gaze/features/series/presentation/enum/search_type.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../get_network_series.mock.dart';

class MockGetSearchedSeriesUseCase extends Mock
    implements GetSearchedSeriesUseCase {}

class MockGetSeriesByGenresUseCase extends Mock
    implements GetSeriesByGenreUseCase {}

void main() {
  late GetSearchedSeriesUseCase getSearchedSeries;
  late GetSeriesByGenreUseCase getSeriesByGenre;
  late GetNetworkSeriesUseCase getNetworkSeries;
  late SeriesListBloc bloc;

  setUp(() {
    getSearchedSeries = MockGetSearchedSeriesUseCase();
    getSeriesByGenre = MockGetSeriesByGenresUseCase();
    getNetworkSeries = MockGetNetworkSeriesUseCase();
    bloc = SeriesListBloc(
      getSearchedSeries: getSearchedSeries,
      getSeriesByGenre: getSeriesByGenre,
      getNetworkSeries: getNetworkSeries,
    );
    registerFallbackValue(Networks.netflix);
    registerFallbackValue(Genres.animation);
  });

  tearDown(() => bloc.close());

  const tSeriesList = [SeriesModel.empty()];
  final tServerFailure = ServerFailure(
    message: 'Test error failure',
    statusCode: '505',
  );

  test('initial state should be [SearchedInitial]', () {
    expect(bloc.state, const SeriesListInitial());
  });

  group('textCase', () {
    const tLoadEvent = LoadSeriesListEvent(
      text: 'teste',
      searchType: SearchType.text,
    );
    blocTest<SeriesListBloc, SeriesListState>(
      'should emit [LoadingSearchedSeries, LoadedSearchedSeries] when '
      '[LoadSearchedListEvent] is added',
      build: () {
        when(() => getSearchedSeries(any())).thenAnswer(
          (_) async => const Right(tSeriesList),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(tLoadEvent),
      expect: () => const <SeriesListState>[
        LoadingSeriesList(),
        LoadedSeriesList(seriesList: tSeriesList),
      ],
      verify: (_) {
        verify(() => getSearchedSeries('teste')).called(1);
        verifyNoMoreInteractions(getSearchedSeries);
      },
    );
    blocTest<SeriesListBloc, SeriesListState>(
      'should emit [LoadingSearchedSeries, ErrorSearchedSeries] when '
      '[LoadSearchedListEvent] is added',
      build: () {
        when(() => getSearchedSeries(any())).thenAnswer(
          (_) async => Left(tServerFailure),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(tLoadEvent),
      expect: () => <SeriesListState>[
        const LoadingSeriesList(),
        ErrorSeriesList(errorMessage: tServerFailure.message),
      ],
      verify: (_) {
        verify(() => getSearchedSeries('teste')).called(1);
        verifyNoMoreInteractions(getSearchedSeries);
      },
    );
  });

  group('networkCase', () {
    blocTest<SeriesListBloc, SeriesListState>(
      'should emit [LoadingSearchedSeries, LoadedSearchedSeries] when '
      '[LoadSearchedListEvent] is added',
      build: () {
        when(() => getNetworkSeries(any())).thenAnswer(
          (_) async => const Right(tSeriesList),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(
        const LoadSeriesListEvent(
          network: Networks.netflix,
          searchType: SearchType.network,
        ),
      ),
      expect: () => const <SeriesListState>[
        LoadingSeriesList(),
        LoadedSeriesList(seriesList: tSeriesList),
      ],
      verify: (_) {
        verify(() => getNetworkSeries(Networks.netflix)).called(1);
        verifyNoMoreInteractions(getNetworkSeries);
      },
    );
    blocTest<SeriesListBloc, SeriesListState>(
      'should emit [LoadingSearchedSeries, ErrorSearchedSeries] when '
      '[LoadSearchedListEvent] is added',
      build: () {
        when(() => getNetworkSeries(any())).thenAnswer(
          (_) async => Left(tServerFailure),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(
        const LoadSeriesListEvent(
          network: Networks.netflix,
          searchType: SearchType.network,
        ),
      ),
      expect: () => <SeriesListState>[
        const LoadingSeriesList(),
        ErrorSeriesList(errorMessage: tServerFailure.message),
      ],
      verify: (_) {
        verify(() => getNetworkSeries(Networks.netflix)).called(1);
        verifyNoMoreInteractions(getNetworkSeries);
      },
    );
  });

  group('networkCase', () {
    blocTest<SeriesListBloc, SeriesListState>(
      'should emit [LoadingSearchedSeries, LoadedSearchedSeries] when '
      '[LoadSearchedListEvent] is added',
      build: () {
        when(() => getNetworkSeries(any())).thenAnswer(
          (_) async => const Right(tSeriesList),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(
        const LoadSeriesListEvent(
          network: Networks.netflix,
          searchType: SearchType.network,
        ),
      ),
      expect: () => const <SeriesListState>[
        LoadingSeriesList(),
        LoadedSeriesList(seriesList: tSeriesList),
      ],
      verify: (_) {
        verify(() => getNetworkSeries(Networks.netflix)).called(1);
        verifyNoMoreInteractions(getNetworkSeries);
      },
    );
    blocTest<SeriesListBloc, SeriesListState>(
      'should emit [LoadingSearchedSeries, ErrorSearchedSeries] when '
      '[LoadSearchedListEvent] is added',
      build: () {
        when(() => getNetworkSeries(any())).thenAnswer(
          (_) async => Left(tServerFailure),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(
        const LoadSeriesListEvent(
          network: Networks.netflix,
          searchType: SearchType.network,
        ),
      ),
      expect: () => <SeriesListState>[
        const LoadingSeriesList(),
        ErrorSeriesList(errorMessage: tServerFailure.message),
      ],
      verify: (_) {
        verify(() => getNetworkSeries(Networks.netflix)).called(1);
        verifyNoMoreInteractions(getNetworkSeries);
      },
    );
  });

  group('genreCase', () {
    blocTest<SeriesListBloc, SeriesListState>(
      'should emit [LoadingSearchedSeries, LoadedSearchedSeries] when '
      '[LoadSearchedListEvent] is added',
      build: () {
        when(() => getSeriesByGenre(any())).thenAnswer(
          (_) async => const Right(tSeriesList),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(
        const LoadSeriesListEvent(
          genre: Genres.animation,
          searchType: SearchType.genre,
        ),
      ),
      expect: () => const <SeriesListState>[
        LoadingSeriesList(),
        LoadedSeriesList(seriesList: tSeriesList),
      ],
      verify: (_) {
        verify(() => getSeriesByGenre(Genres.animation)).called(1);
        verifyNoMoreInteractions(getSeriesByGenre);
      },
    );
    blocTest<SeriesListBloc, SeriesListState>(
      'should emit [LoadingSearchedSeries, ErrorSearchedSeries] when '
      '[LoadSearchedListEvent] is added',
      build: () {
        when(() => getSeriesByGenre(any())).thenAnswer(
          (_) async => Left(tServerFailure),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(
        const LoadSeriesListEvent(
          genre: Genres.animation,
          searchType: SearchType.genre,
        ),
      ),
      expect: () => <SeriesListState>[
        const LoadingSeriesList(),
        ErrorSeriesList(errorMessage: tServerFailure.message),
      ],
      verify: (_) {
        verify(() => getSeriesByGenre(Genres.animation)).called(1);
        verifyNoMoreInteractions(getSeriesByGenre);
      },
    );
  });
}
