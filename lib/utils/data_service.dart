import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:the_movies/models/films.dart';
import 'credentials.dart';

class DataService {
  static const queryParameters = {'api_key': apiKey};

  Future<List<Films>> getNowPlayingMovies() async {
    final uri = Uri.https(
        'api.themoviedb.org', '/3/movie/now_playing', queryParameters);
    final response = await http.get(uri);
    if (response.statusCode != 200) {
      throw Exception('Failed to connect API');
    }
    final List<Films> filmsList = List<Films>.from(
            jsonDecode(response.body)['results'].map((e) => Films.fromJson(e)))
        .toList();
    return filmsList;
  }

  Future<List<Films>> getPopularMovies() async {
    final uri =
        Uri.https('api.themoviedb.org', '/3/movie/popular', queryParameters);
    final response = await http.get(uri);
    if (response.statusCode != 200) {
      throw Exception('Failed to connect API');
    }
    final List<Films> filmsList = List<Films>.from(
            jsonDecode(response.body)['results'].map((e) => Films.fromJson(e)))
        .toList();
    return filmsList;
  }

  Future<List> getActorsForFilm(int movieId) async {
    final uri = Uri.https(
        'api.themoviedb.org', '/3/movie/$movieId/credits', queryParameters);
    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception('Failed to connect API');
    }

    final List actorsList = jsonDecode(response.body)['cast'];
    return actorsList;
  }
}
