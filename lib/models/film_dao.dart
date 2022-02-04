import 'package:floor/floor.dart';

import 'film.dart';

@dao
abstract class FilmDao {
  @Query('SELECT * FROM film')
  Future<List<Film>> findAllFilms();

  @Query('SELECT * FROM film WHERE id = :id')
  Stream<Film?> findFilmById(int id);

  @Query('SELECT * FROM film')
  Stream<List<Film>> findAllFilmsAsStream();

  @insert
  Future<void> insertFilm(Film film);

  @update
  Future<void> updateFilm(Film film);

  @update
  Future<void> updateFilms(List<Film> films);

  @delete
  Future<void> deleteFilm(Film film);

  @delete
  Future<void> deleteFilms(List<Film> films);
}
