import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movies/models/films.dart';
import 'package:the_movies/utils/data_service.dart';

class PopularCubit extends Cubit<List<Films>> {
  final _dataService = DataService();

  PopularCubit() : super([]);

  void getPopularFilms() async => emit(await _dataService.getPopularMovies());
}
