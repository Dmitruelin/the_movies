import 'dart:math';

import 'package:dio/dio.dart';
import 'package:the_movies/models/actor.dart';
import 'package:the_movies/models/film.dart';
import 'package:the_movies/utils/data_service.dart';

import 'credentials.dart';

class DataServiceImplementation implements DataService {
  final Dio dio = Dio();
  static  Map<String, String> queryParameters = {
    'api_key': apiKey,
  };

  @override
  Future<List> getActorsList(int movieId) async {
    final uri = Uri.https(
        'api.themoviedb.org', '/3/movie/$movieId/credits', queryParameters);
    final response = await dio.getUri(uri);

    if (response.statusCode != 200) {
      throw Exception('Failed to connect API');
    }

    final List actorsList = response.data['cast'];

    return actorsList;
  }

  @override
  Future<List<Film>> getNowPlayingFilms(String locale) async {
    int randomIntForPageInQuery = Random().nextInt(10) + 1;
    final uri = Uri.https('api.themoviedb.org', '/3/movie/now_playing', {
      'api_key': apiKey,
      'page': randomIntForPageInQuery.toString(),
      'language' : locale,
    });

    final response = await dio.postUri(uri);

    if (response.statusCode != 200) {
      throw Exception('Failed to connect API');
    }

    final List<Film> nowPlayingFilmsList =
        List<Film>.from(response.data['results'].map((e) => Film.fromJson(e)))
            .toList();

    return nowPlayingFilmsList;
  }

  @override
  Future<List<Film>> getPopularFilms(String locale) async {
    final uri =
        Uri.https('api.themoviedb.org', '/3/movie/popular', {
          'api_key': apiKey,
          'language' : locale,
        });
    final response = await dio.getUri(uri);

    if (response.statusCode != 200) {
      throw Exception('Failed to connect API');
    }

    final List<Film> filmsList =
        List<Film>.from(response.data['results'].map((e) => Film.fromJson(e)))
            .toList();

    return filmsList;
  }

  @override
  Future<Actor> getActorPersonInfo(int actorId) async {
    final uri =
        Uri.https('api.themoviedb.org', '/3/person/$actorId', queryParameters);
    final response = await dio.getUri(uri);

    if (response.statusCode != 200) {
      throw Exception('Failed to connect API');
    }
    final Actor actor = Actor.fromJson(response.data);
    return actor;
  }
}
