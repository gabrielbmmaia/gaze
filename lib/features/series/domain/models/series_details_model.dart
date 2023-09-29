import 'package:equatable/equatable.dart';
import 'package:gaze/features/series/domain/models/seasons_model.dart';

class SeriesDetailsModel extends Equatable {
  const SeriesDetailsModel({
    required this.id,
    required this.firstAirDate,
    required this.lastAirDate,
    required this.inProduction,
    required this.backdropPath,
    required this.posterPath,
    required this.originalLanguage,
    required this.genres,
    required this.name,
    required this.originalName,
    required this.networks,
    required this.episodes,
    required this.seasons,
    required this.overview,
    required this.tagline,
    required this.voteAverage,
  });

  SeriesDetailsModel.empty()
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
          seasons: [],
          overview: '',
          tagline: '',
          voteAverage: 0,
        );

  final String id;
  final String firstAirDate;
  final String lastAirDate;
  final bool inProduction;
  final String backdropPath;
  final String posterPath;
  final String originalLanguage;
  final List<String> genres;
  final String name;
  final String originalName;
  final List<String> networks;
  final int episodes;
  final List<SeasonsModel> seasons;
  final String overview;
  final String tagline;
  final double voteAverage;

  @override
  List<dynamic> get props => [
        id,
        firstAirDate,
        lastAirDate,
        inProduction,
        backdropPath,
        posterPath,
        originalLanguage,
        genres,
        name,
        originalName,
        networks,
        episodes,
        seasons,
        overview,
        tagline,
        voteAverage,
      ];

  @override
  String toString() {
    return 'SeriesDetailsModel{id: $id, firstAirDate: $firstAirDate, '
        'lastAirDate: $lastAirDate, inProduction: $inProduction, '
        'backdropPath: $backdropPath, posterPath: $posterPath, '
        'originalLanguage: $originalLanguage, genres: $genres, name: $name, '
        'originalName: $originalName, networks: $networks, '
        'episodes: $episodes, seasons: $seasons, overview: $overview, '
        'tagLine: $tagline, voteAverage: $voteAverage}';
  }
}
