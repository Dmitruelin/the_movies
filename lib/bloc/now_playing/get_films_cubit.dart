import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movies/models/films.dart';
import 'package:the_movies/utils/data_service.dart';

class GetFilmsCubit extends Cubit<List<Films>> {
  final DataService _dataService;

  DataService get dataService => _dataService;
  GetFilmsCubit(this._dataService) : super([]);

  void getFilms() async => emit(await dataService.getNowPlayingFilms());

  void getPopularFilms() async => emit(await dataService.getPopularFilms());
}
