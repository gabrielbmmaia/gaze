/// Todos possíveis Genres do aplicativo
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

/// Passar um [Genres] para receber o Id dela.
/// Ex: getGenresId[Genres.animation] para receber '10759'
Map<Genres, String> getGenresId = {
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

/// Passar um [Genres] para receber o nome dela.
/// Ex: getGenresName[Genres.animation] para receber 'Animação'
Map<Genres, String> getGenresName = {
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
