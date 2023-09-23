import 'package:equatable/equatable.dart';

class SeriesModel extends Equatable {
  const SeriesModel({
    required this.posterPath,
    required this.voteAverage,
    required this.id,
    required this.originalName,
  });

  const SeriesModel.empty()
      : this(
          id: '',
          posterPath: '',
          voteAverage: '',
          originalName: '',
        );

  final String posterPath;
  final String voteAverage;
  final String id;
  final String originalName;

  @override
  String toString() {
    return 'SeriesModel{posterPath: $posterPath, voteAverage: $voteAverage, '
        'id: $id, originalName: $originalName}';
  }

  @override
  List<dynamic> get props => [posterPath, voteAverage, id, originalName];
}
