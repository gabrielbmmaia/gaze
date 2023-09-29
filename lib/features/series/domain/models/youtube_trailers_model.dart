import 'package:equatable/equatable.dart';

class YoutubeTrailersModel extends Equatable {
  const YoutubeTrailersModel({
    required this.trailerKey,
    required this.trailerTitle,
  });

  const YoutubeTrailersModel.empty() : this(trailerKey: '', trailerTitle: '');

  final String trailerKey;
  final String trailerTitle;

  @override
  List<String> get props => [trailerKey, trailerTitle];
}
