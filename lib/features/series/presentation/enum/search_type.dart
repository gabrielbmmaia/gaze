import 'package:gaze/core/enums/genres.dart';
import 'package:gaze/core/enums/networks.dart';

enum SearchType {
  text,
  genre,
  network,
}

class NavigationSearchTypeArgs {
  NavigationSearchTypeArgs.textSearch(this.text)
      : searchType = SearchType.text,
        network = null,
        genre = null;

  NavigationSearchTypeArgs.genreSearch(this.genre)
      : searchType = SearchType.genre,
        network = null,
        text = '';

  NavigationSearchTypeArgs.networkSearch(this.network)
      : searchType = SearchType.network,
        text = '',
        genre = null;

  final SearchType searchType;
  final String text;
  final Genres? genre;
  final Networks? network;
}
