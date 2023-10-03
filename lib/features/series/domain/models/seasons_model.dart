import 'package:equatable/equatable.dart';

class SeasonsModel extends Equatable {
  const SeasonsModel({
    required this.airDate,
    required this.name,
    required this.voteAverage,
    required this.posterPath,
    required this.episodeCount,
  });

  const SeasonsModel.empty()
      : this(
          posterPath: '',
          voteAverage: 0,
          name: '',
          airDate: '',
          episodeCount: 0,
        );

  final String? airDate;
  final String name;
  final double voteAverage;
  final String posterPath;
  final int episodeCount;

  @override
  List<dynamic> get props => [airDate, name, voteAverage, posterPath];
}
