import 'package:gaze/core/utils/typedefs.dart';
import 'package:gaze/features/series/domain/models/series_model.dart';

class SeriesEntity extends SeriesModel {
  const SeriesEntity({
    required super.posterPath,
    required super.id,
    required super.name,
  });

  factory SeriesEntity.fromJson(Map<String, dynamic> json) {
    return SeriesEntity(
      posterPath: json['poster_path'] as String? ?? '',
      id: json['id'].toString(),
      name: json['name'] as String,
    );
  }

  const SeriesEntity.empty()
      : this(
          name: '',
          posterPath: '',
          id: '',
        );

  DataMap toMap() {
    return {
      'poster_path': posterPath,
      'id': id,
      'name': name,
    };
  }
}
