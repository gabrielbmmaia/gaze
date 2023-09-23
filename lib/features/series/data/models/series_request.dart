import 'package:gaze/core/utils/typedefs.dart';
import 'package:gaze/features/series/data/models/series_entity.dart';

class SeriesRequest {
  const SeriesRequest({
    required this.page,
    required this.result,
  });

  factory SeriesRequest.fromJson(DataMap json) {
    final page = json['page'] as String;
    final result = (json['result'] as List<dynamic>)
        .map((item) => SeriesEntity.fromJson(item as Map<String, dynamic>))
        .toList();

    return SeriesRequest(
      page: page,
      result: result,
    );
  }

  SeriesRequest.empty() : this(
    page: '',
    result: [],
  );

  final String page;
  final List<SeriesEntity> result;

  DataMap toMap() {
    return {
      'page': page,
      'result': result,
    };
  }
}
