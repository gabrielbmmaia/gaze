import 'package:gaze/features/series/data/models/series_entity.dart';
import 'package:gaze/features/series/domain/models/series_model.dart';

class SeriesMapper {
  SeriesModel toDomain(SeriesEntity entity) {
    return SeriesModel(
      id: entity.id,
      posterPath: entity.posterPath,
      name: entity.name,
    );
  }

  SeriesEntity toData(SeriesModel model) {
    return SeriesEntity(
      id: model.id,
      posterPath: model.posterPath,
      name: model.name,
    );
  }
}
