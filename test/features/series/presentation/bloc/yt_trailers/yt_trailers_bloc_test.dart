import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:gaze/core/errors/failures.dart';
import 'package:gaze/features/series/domain/models/youtube_trailers_model.dart';
import 'package:gaze/features/series/domain/usecases/get_youtube_trailers.dart';
import 'package:gaze/features/series/presentation/bloc/yt_trailers/yt_trailers_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockGetYoutubeTrailersUseCase extends Mock
    implements GetYoutubeTrailersUseCase {}

void main() {
  late GetYoutubeTrailersUseCase getYoutubeTrailers;
  late YtTrailersBloc bloc;

  setUp(() {
    getYoutubeTrailers = MockGetYoutubeTrailersUseCase();
    bloc = YtTrailersBloc(getYoutubeTrailers: getYoutubeTrailers);
  });

  tearDown(() => bloc.close());

  test('initial state should be [YtTrailersInitial]', () {
    expect(bloc.state, const YtTrailersInitial());
  });

  const tTrailersList = [YoutubeTrailersModel.empty()];
  final tServerFailure = ServerFailure(
    message: 'Test error failure',
    statusCode: '505',
  );

  group('getYtTrailers', () {
    blocTest<YtTrailersBloc, YtTrailersState>(
      'should emit [LoadingYtTrailers, LoadedYtTrailers] when '
      '[LoadYtTrailersEvent] is added',
      build: () {
        when(() => getYoutubeTrailers(any())).thenAnswer(
          (_) async => const Right(tTrailersList),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(const LoadYtTrailersEvent(seriesId: '123456')),
      expect: () => const <YtTrailersState>[
        LoadingYtTrailers(),
        LoadedYtTrailers(trailersList: tTrailersList),
      ],
      verify: (_) {
        verify(() => getYoutubeTrailers('123456')).called(1);
        verifyNoMoreInteractions(getYoutubeTrailers);
      },
    );
    blocTest<YtTrailersBloc, YtTrailersState>(
      'should emit [LoadingYtTrailers, ErrorYtTrailers] when '
          '[LoadYtTrailersEvent] is added',
      build: () {
        when(() => getYoutubeTrailers(any())).thenAnswer(
              (_) async => Left(tServerFailure),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(const LoadYtTrailersEvent(seriesId: '123456')),
      expect: () => const <YtTrailersState>[
        LoadingYtTrailers(),
        ErrorYtTrailers(),
      ],
      verify: (_) {
        verify(() => getYoutubeTrailers('123456')).called(1);
        verifyNoMoreInteractions(getYoutubeTrailers);
      },
    );
  });
}
