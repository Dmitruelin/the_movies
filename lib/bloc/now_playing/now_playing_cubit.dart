import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movies/models/films.dart';
import 'package:the_movies/utils/data_service.dart';

class NowPlayingCubit extends Cubit<List<Films>> {
  final _dateService = DataService();

  NowPlayingCubit() : super([]);

  void getFilms() async => emit(await _dateService.getNowPlayingMovies());
}
