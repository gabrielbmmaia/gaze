import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:gaze/core/errors/failures.dart';
import 'package:gaze/features/series/domain/models/series_model.dart';
import 'package:gaze/features/series/domain/usecases/get_searched_series.dart';
import 'package:gaze/features/series/presentation/bloc/searched/searched_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockGetSearchedSeriesUseCase extends Mock
    implements GetSearchedSeriesUseCase {}

void main() {
  late GetSearchedSeriesUseCase getSearchedSeries;
  late SearchedBloc bloc;

  setUp(() {
    getSearchedSeries = MockGetSearchedSeriesUseCase();
    bloc = SearchedBloc(getSearchedSeries: getSearchedSeries);
  });

  tearDown(() => bloc.close());

  const tSeriesList = [SeriesModel.empty()];
  final tServerFailure = ServerFailure(
    message: 'Test error failure',
    statusCode: '505',
  );

  test('initial state should be [SearchedInitial]', () {
    expect(bloc.state, const SearchedInitial());
  });

  group('searchedBloc', () {
    blocTest<SearchedBloc, SearchedState>(
      'should emit [LoadingSearchedSeries, LoadedSearchedSeries] when '
          '[LoadSearchedListEvent] is added',
      build: () {
        when(() => getSearchedSeries(any())).thenAnswer(
          (_) async => const Right(tSeriesList),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(const LoadSearchedListEvent(text: 'teste')),
      expect: () => const <SearchedState>[
        LoadingSearchedSeries(),
        LoadedSearchedSeries(searchedList: tSeriesList),
      ],
      verify: (_) {
        verify(() => getSearchedSeries('teste')).called(1);
        verifyNoMoreInteractions(getSearchedSeries);
      },
    );
    blocTest<SearchedBloc, SearchedState>(
      'should emit [LoadingSearchedSeries, ErrorSearchedSeries] when '
          '[LoadSearchedListEvent] is added',
      build: () {
        when(() => getSearchedSeries(any())).thenAnswer(
              (_) async => Left(tServerFailure),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(const LoadSearchedListEvent(text: 'teste')),
      expect: () => const <SearchedState>[
        LoadingSearchedSeries(),
        ErrorSearchedSeries(),
      ],
      verify: (_) {
        verify(() => getSearchedSeries('teste')).called(1);
        verifyNoMoreInteractions(getSearchedSeries);
      },
    );
  });
}
