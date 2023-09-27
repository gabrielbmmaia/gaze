import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:gaze/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:gaze/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:gaze/features/auth/domain/repositories/auth_repo.dart';
import 'package:gaze/features/auth/domain/usecases/sign_in.dart';
import 'package:gaze/features/auth/domain/usecases/sign_up.dart';
import 'package:gaze/features/auth/domain/usecases/update_user.dart';
import 'package:gaze/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:gaze/features/series/data/data_sources/series_remote_data_source.dart';
import 'package:gaze/features/series/data/repositories/series_repo_impl.dart';
import 'package:gaze/features/series/domain/repositories/series_repo.dart';
import 'package:gaze/features/series/domain/usecases/get_amazon_series.dart';
import 'package:gaze/features/series/domain/usecases/get_disney_series.dart';
import 'package:gaze/features/series/domain/usecases/get_hbo_series.dart';
import 'package:gaze/features/series/domain/usecases/get_netflix_series.dart';
import 'package:gaze/features/series/domain/usecases/get_popular_series.dart';
import 'package:gaze/features/series/domain/usecases/get_top_rated_series.dart';
import 'package:gaze/features/series/domain/usecases/get_trending_series.dart';
import 'package:gaze/features/series/presentation/bloc/amazon/amazon_bloc.dart';
import 'package:gaze/features/series/presentation/bloc/disney/disney_bloc.dart';
import 'package:gaze/features/series/presentation/bloc/hbo/hbo_bloc.dart';
import 'package:gaze/features/series/presentation/bloc/netflix/netflix_bloc.dart';
import 'package:gaze/features/series/presentation/bloc/popular/popular_bloc.dart';
import 'package:gaze/features/series/presentation/bloc/top_rated/top_rated_bloc.dart';
import 'package:gaze/features/series/presentation/bloc/trending/trending_bloc.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  await _seriesInit();
  await _authInit();
}

Future<void> _seriesInit() async {
  sl
    ..registerFactory(() => TopRatedBloc(getTopRatedSeries: sl()))
    ..registerFactory(() => PopularBloc(getPopularSeries: sl()))
    ..registerFactory(() => TrendingBloc(getTrendingSeries: sl()))
    ..registerFactory(() => NetflixBloc(getNetflixSeries: sl()))
    ..registerFactory(() => AmazonBloc(getAmazonSeries: sl()))
    ..registerFactory(() => DisneyBloc(getDisneySeries: sl()))
    ..registerFactory(() => HboBloc(getHBOSeries: sl()))

    ..registerLazySingleton(() => GetPopularSeriesUseCase(sl()))
    ..registerLazySingleton(() => GetTrendingSeriesUseCase(sl()))
    ..registerLazySingleton(() => GetTopRatedSeriesUseCase(sl()))
    ..registerLazySingleton(() => GetNetflixSeriesUseCase(sl()))
    ..registerLazySingleton(() => GetAmazonSeriesUseCase(sl()))
    ..registerLazySingleton(() => GetDisneySeriesUseCase(sl()))
    ..registerLazySingleton(() => GetHBOSeriesUseCase(sl()))

    ..registerLazySingleton<SeriesRepo>(() => SeriesRepoImpl(sl()))
    ..registerLazySingleton<SeriesRemoteDataSource>(
      SeriesRemoteDataSourceImpl.new,
    );
}

Future<void> _authInit() async {
  sl
    ..registerFactory(
      () => AuthBloc(
        signIn: sl(),
        signUp: sl(),
        updateUser: sl(),
      ),
    )

    //Use Cases
    ..registerLazySingleton(() => SignInUseCase(sl()))
    ..registerLazySingleton(() => SignUpUseCase(sl()))
    ..registerLazySingleton(() => UpdateUserUseCase(sl()))

    //Repository
    ..registerLazySingleton<AuthRepo>(() => AuthRepoImpl(sl()))

    //Data Source
    ..registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(
        authClient: sl(),
        cloudStoreClient: sl(),
        dbClient: sl(),
      ),
    )

    //Firebase
    ..registerLazySingleton(() => FirebaseAuth.instance)
    ..registerLazySingleton(() => FirebaseFirestore.instance)
    ..registerLazySingleton(() => FirebaseStorage.instance);
}
