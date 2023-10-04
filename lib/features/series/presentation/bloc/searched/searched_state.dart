part of 'searched_bloc.dart';

abstract class SearchedState extends Equatable {
  const SearchedState();

  @override
  List<Object> get props => [];
}

class SearchedInitial extends SearchedState {
  const SearchedInitial();
}

class LoadingSearchedSeries extends SearchedState {
  const LoadingSearchedSeries();
}

class LoadedSearchedSeries extends SearchedState {
  const LoadedSearchedSeries({required this.searchedList});

  final List<SeriesModel> searchedList;

  @override
  List<Object> get props => [searchedList];
}

class ErrorSearchedSeries extends SearchedState {
  const ErrorSearchedSeries();
}
