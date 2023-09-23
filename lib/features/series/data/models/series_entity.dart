import 'package:gaze/core/utils/typedefs.dart';
import 'package:gaze/features/series/domain/models/series_model.dart';

class SeriesEntity extends SeriesModel {
  const SeriesEntity({
    required super.posterPath,
    required super.voteAverage,
    required super.id,
    required super.originalName,
  });

  factory SeriesEntity.fromJson(DataMap json) {
    return SeriesEntity(
      posterPath: json['posterPath'] as String,
      voteAverage: json['voteAverage'].toString(),
      id: json['id'].toString(),
      originalName: json['originalName'] as String,
    );
  }

  const SeriesEntity.empty()
      : this(
          originalName: '',
          voteAverage: '',
          posterPath: '',
          id: '',
        );

  DataMap toMap() {
    return {
      'posterPath': posterPath,
      'voteAverage': voteAverage,
      'id': id,
      'originalName': originalName,
    };
  }
}
