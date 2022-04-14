import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movies/models/film.dart';
import 'package:the_movies/utils/data_service.dart';

class GetFilmsCubit extends Cubit<List<Film>> {
  final DataService _dataService;

  DataService get dataService => _dataService;

  GetFilmsCubit(this._dataService) : super([]);

  void getFilms(String locale) async {
    final List<Film> filmsList = await dataService.getNowPlayingFilms(locale);
    final filteredList =
        filmsList.where((element) => element.posterPath != null).toList();
    emit(filteredList);
  }
}
