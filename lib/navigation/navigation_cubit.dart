import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movies/models/film.dart';

part 'navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(const StartPageState());

  void goToStartPage() => emit(const StartPageState());

  void goToDescriptionPage(Film film) => emit(DescriptionPageState(film: film));

  void goToActorsDetailsPage() => emit(const ActorDetailsPageState());

  void goToActorsPage({required int movieId}) =>
      emit(ActorsListPageState(movieId: movieId));

  void clearState() => emit(const ClearState());

  void popExtra() {
    if (state is ActorDetailsPageState) {
      goToActorsDetailsPage();
    } else if (state is DescriptionPageState) {
      goToDescriptionPage(state.props[0] as Film);
    } else if (state is ActorsListPageState) {
      goToActorsPage(movieId: state.props[0] as int);
    } else {
      goToStartPage();
    }
  }
}
