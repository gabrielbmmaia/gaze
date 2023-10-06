import 'package:gaze/features/series/data/models/series_entity.dart';
import 'package:gaze/features/series/domain/models/series_model.dart';

class SeriesMapper {
  SeriesModel toDomain(SeriesEntity entity) {
    return SeriesModel(
      id: entity.id,
      posterPath: entity.posterPath,
      voteAverage: entity.voteAverage,
      name: entity.name,
    );
  }

  SeriesEntity toData(SeriesModel model) {
    return SeriesEntity(
      id: model.id,
      posterPath: model.posterPath,
      voteAverage: model.voteAverage,
      name: model.name,
    );
  }
}
