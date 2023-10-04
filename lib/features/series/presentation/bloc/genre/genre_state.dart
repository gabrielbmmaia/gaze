part of 'genre_bloc.dart';

abstract class GenreState extends Equatable {
  const GenreState();

  @override
  List<Object> get props => [];
}

class GenreInitial extends GenreState {
  const GenreInitial();
}

class LoadingGenreList extends GenreState {
  const LoadingGenreList();
}

class LoadedGenreList extends GenreState {
  const LoadedGenreList({required this.genreList});

  final List<SeriesModel> genreList;

  @override
  List<Object> get props => [genreList];
}

class ErrorGenreList extends GenreState {
  const ErrorGenreList();
}
