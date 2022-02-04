import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:the_movies/models/actor.dart';
import 'package:the_movies/models/film.dart';
import 'package:the_movies/utils/data_service.dart';

import 'credentials.dart';

class DataServiceImplementation implements DataService {
  static const queryParameters = {'api_key': apiKey};

  @override
  Future<List> getActorsList(int movieId) async {
    final uri = Uri.https(
        'api.themoviedb.org', '/3/movie/$movieId/credits', queryParameters);
    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception('Failed to connect API');
    }

    final List actorsList = jsonDecode(response.body)['cast'];

    return actorsList;
  }

  @override
  Future<List<Film>> getNowPlayingFilms() async {
    final uri = Uri.https(
        'api.themoviedb.org', '/3/movie/now_playing', queryParameters);
    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception('Failed to connect API');
    }

    final List<Film> filmsList = List<Film>.from(
            jsonDecode(response.body)['results'].map((e) => Film.fromJson(e)))
        .toList();
    return filmsList;
  }

  @override
  Future<List<Film>> getPopularFilms() async {
    final uri =
        Uri.https('api.themoviedb.org', '/3/movie/popular', queryParameters);
    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception('Failed to connect API');
    }

    final List<Film> filmsList = List<Film>.from(
            jsonDecode(response.body)['results'].map((e) => Film.fromJson(e)))
        .toList();
    return filmsList;
  }

  @override
  Future<Actor> getActorPersonInfo(int actorId) async {
    final uri =
        Uri.https('api.themoviedb.org', '/3/person/$actorId', queryParameters);
    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception('Failed to connect API');
    }

    final Actor actor = Actor.fromJson(jsonDecode(response.body));
    return actor;
  }
}
