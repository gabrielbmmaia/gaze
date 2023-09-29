import 'package:gaze/features/series/domain/models/youtube_trailers_model.dart';

class YoutubeTrailersEntity extends YoutubeTrailersModel {
  const YoutubeTrailersEntity({
    required super.trailerKey,
    required super.trailerTitle,
  });

  factory YoutubeTrailersEntity.fromMap(Map<String, dynamic> map) {
    return YoutubeTrailersEntity(
      trailerKey: map['key'] as String,
      trailerTitle: map['name'] as String,
    );
  }

  const YoutubeTrailersEntity.empty() : this(trailerKey: '', trailerTitle: '');

  Map<String, dynamic> toMap() {
    return {
      'key': trailerKey,
      'name': trailerTitle,
    };
  }
}
