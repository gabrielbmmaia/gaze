enum Genres {
  actionAdventure,
  animation,
  comedy,
  crime,
  documentary,
  drama,
  family,
  kids,
  mystery,
  reality,
  sciFiFantasy,
}

Map<Genres, String> genreIds = {
  Genres.actionAdventure: '10759',
  Genres.animation: '16',
  Genres.comedy: '35',
  Genres.crime: '80',
  Genres.documentary: '99',
  Genres.drama: '18',
  Genres.family: '10751',
  Genres.kids: '10762',
  Genres.mystery: '9648',
  Genres.reality: '10764',
  Genres.sciFiFantasy: '10765',
};

Map<Genres, String> genreNameFromGenres = {
  Genres.actionAdventure: 'Ação e Aventura',
  Genres.animation: 'Animação',
  Genres.comedy: 'Comédia',
  Genres.crime: 'Crime',
  Genres.documentary: 'Documentário',
  Genres.drama: 'Drama',
  Genres.family: 'Família',
  Genres.kids: 'Kids',
  Genres.mystery: 'Mistério',
  Genres.reality: 'Reality',
  Genres.sciFiFantasy: 'Sci-Fi e Fantasia',
};

Map<String, String> genreNameFromId = {
  '10759': 'Ação e Aventura',
  '16': 'Animação',
  '35': 'Comédia',
  '80': 'Crime',
  '99': 'Documentário',
  '18': 'Drama',
  '10751': 'Família',
  '10762': 'Kids',
  '9648': 'Mistério',
  '10764': 'Reality',
  '10765': 'Sci-Fi e Fantasia',
};
