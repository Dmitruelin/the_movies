import 'dart:async';

import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import '../models/film.dart';
import '../models/film_dao.dart';

part 'database.g.dart';

@Database(version: 1, entities: [Film])
abstract class AppDatabase extends FloorDatabase {
  FilmDao get filmDao;
}
