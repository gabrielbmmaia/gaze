import 'package:equatable/equatable.dart';

class SeriesModel extends Equatable {
  const SeriesModel({
    required this.posterPath,
    required this.id,
    required this.name,
  });

  const SeriesModel.empty()
      : this(
          id: '',
          posterPath: '',
          name: '',
        );

  final String? posterPath;
  final String id;
  final String name;

  @override
  String toString() {
    return 'SeriesModel{posterPath: $posterPath, '
        'id: $id, originalName: $name}';
  }

  @override
  List<String> get props => [id];
}
