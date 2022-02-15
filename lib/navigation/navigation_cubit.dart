import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movies/models/film.dart';

part 'navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(const StartPageState());

  NavigationState previousState = const StartPageState();

  void goToStartPage() => emit(const StartPageState());

  void goToDescriptionPage(Film film) {
    previousState = state;
    emit(DescriptionPageState(film: film));
  }

  void goToActorsDetailsPage(int actorId) {
    previousState = state;
    emit(ActorDetailsPageState(actorId: actorId));
  }

  void goToActorsPage(int movieId, Film film) {
    previousState = state;
    emit(ActorsListPageState(movieId: movieId, film: film));
  }
}
