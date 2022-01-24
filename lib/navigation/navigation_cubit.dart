import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movies/models/films.dart';

class NavigationCubit extends Cubit<Films?> {
  NavigationCubit() : super(null);

  void showDetailsOfFilm(Films film) => emit(film);

  void showActorsFromTheFilm() async => emit;

  void popToStartPage() => emit(null);
}
