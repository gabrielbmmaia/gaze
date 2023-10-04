part of 'genre_bloc.dart';

abstract class GenreEvent extends Equatable {
  const GenreEvent();
}

class LoadGenreListEvent extends GenreEvent {
  const LoadGenreListEvent({required this.genreId});

  final String genreId;

  @override
  List<String> get props => [genreId];
}
