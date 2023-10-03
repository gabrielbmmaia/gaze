import 'package:gaze/features/series/domain/models/seasons_model.dart';

class SeasonsEntity extends SeasonsModel {
  const SeasonsEntity({
    required super.airDate,
    required super.name,
    required super.voteAverage,
    required super.posterPath,
    required super.episodeCount,
  });

  factory SeasonsEntity.fromMap(Map<String, dynamic> map) {
    return SeasonsEntity(
      airDate: map['air_date'] as String?,
      name: map['name'] as String? ?? '',
      voteAverage: map['vote_average'] as double? ?? 0,
      posterPath: map['poster_path'] as String? ?? '',
      episodeCount: map['episode_count'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'air_date': airDate,
      'name': name,
      'vote_average': voteAverage,
      'poster_path': posterPath,
    };
  }
}
