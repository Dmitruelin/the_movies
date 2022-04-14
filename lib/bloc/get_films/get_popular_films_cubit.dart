import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movies/utils/data_service.dart';

import '../../models/film.dart';

class GetPopularFilms extends Cubit<List<Film>> {
  final DataService _dataService;

  DataService get dataService => _dataService;

  GetPopularFilms(this._dataService) : super([]);

  void getPopularFilms(String locale) async => emit(await dataService.getPopularFilms(locale));
}
