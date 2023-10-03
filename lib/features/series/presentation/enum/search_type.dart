enum SearchType {
  text,
  genre,
}

class NavigationSearchTypeArgs {
  NavigationSearchTypeArgs.textSearch(this.searchText)
      : searchType = SearchType.text,
        genreId = '';

  NavigationSearchTypeArgs.genreSearch(this.genreId)
      : searchType = SearchType.genre,
        searchText = '';

  final SearchType searchType;
  final String searchText;
  final String genreId;
}
