class SWServer {
  static const String _swapi = 'https://swapi.dev/api';
  static const String _people = '$_swapi/people';
  static const String _films = '$_swapi/films';
  static String listCharacters({
    required String page,
    required String pageSize,
  }) =>
      "$_people?page=$page&page_size=$pageSize";

  static String getFilm(String id) => "$_films/$id";
}
