import 'package:equatable/equatable.dart';

class SeriesModel extends Equatable {
  const SeriesModel({
    required this.posterPath,
    required this.voteAverage,
    required this.id,
    required this.name,
  });

  const SeriesModel.empty()
      : this(
          id: '',
          posterPath: '',
          voteAverage: '',
          name: '',
        );

  final String? posterPath;
  final String voteAverage;
  final String id;
  final String name;

  @override
  String toString() {
    return 'SeriesModel{posterPath: $posterPath, voteAverage: $voteAverage, '
        'id: $id, originalName: $name}';
  }

  @override
  List<dynamic> get props => [posterPath, voteAverage, id, name];
}
