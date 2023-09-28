import 'package:gaze/features/series/domain/models/series_details_model.dart';

class SeriesDetailsEntity extends SeriesDetailsModel {
  const SeriesDetailsEntity({
    required super.id,
    required super.firstAirDate,
    required super.lastAirDate,
    required super.inProduction,
    required super.backdropPath,
    required super.posterPath,
    required super.originalLanguage,
    required super.genres,
    required super.name,
    required super.originalName,
    required super.networks,
    required super.episodes,
    required super.seasons,
    required super.overview,
    required super.tagline,
    required super.voteAverage,
  });

  SeriesDetailsEntity.empty()
      : this(
          id: '',
          firstAirDate: '',
          lastAirDate: '',
          inProduction: false,
          backdropPath: '',
          posterPath: '',
          originalLanguage: '',
          genres: [],
          name: '',
          originalName: '',
          networks: [],
          episodes: 0,
          seasons: 0,
          overview: '',
          tagline: '',
          voteAverage: 0,
        );

  factory SeriesDetailsEntity.fromJson(Map<String, dynamic> map) {
    final networksList = map['networks'] as List<dynamic>;
    final genresList = map['genres'] as List<dynamic>;
    final networkNames =
        networksList.map((network) => network['name'] as String).toList();
    final genreNames =
        genresList.map((genre) => genre['name'] as String).toList();

    return SeriesDetailsEntity(
      id: map['id'].toString(),
      firstAirDate: map['first_air_date'] as String,
      lastAirDate: map['last_air_date'] as String,
      inProduction: map['in_production'] as bool,
      backdropPath: map['backdrop_path'] as String,
      posterPath: map['poster_path'] as String,
      originalLanguage: map['original_language'] as String,
      genres: genreNames,
      name: map['name'] as String,
      originalName: map['original_name'] as String,
      networks: networkNames,
      episodes: map['number_of_episodes'] as int,
      seasons: map['number_of_seasons'] as int,
      overview: map['overview'] as String,
      tagline: map['tagline'] as String,
      voteAverage: map['vote_average'] as double,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'first_air_date': firstAirDate,
      'last_air_date': lastAirDate,
      'in_production': inProduction,
      'backdrop_path': backdropPath,
      'poster_path': posterPath,
      'original_language': originalLanguage,
      'genres': genres,
      'name': name,
      'original_name': originalName,
      'networks': networks,
      'number_of_episodes': episodes,
      'number_of_seasons': seasons,
      'overview': overview,
      'tagline': tagline,
      'vote_average': voteAverage,
    };
  }
}
