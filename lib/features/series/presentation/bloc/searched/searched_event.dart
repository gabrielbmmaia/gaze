part of 'searched_bloc.dart';

abstract class SearchedEvent extends Equatable {
  const SearchedEvent();

  @override
  List<Object?> get props => [];
}

class LoadSearchedListEvent extends SearchedEvent {
  const LoadSearchedListEvent({required this.text});

  final String text;
}
