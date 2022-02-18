part of 'navigation_cubit.dart';

abstract class NavigationState extends Equatable {
  const NavigationState();

  @override
  List<Object?> get props => [];
}

class StartPageState extends NavigationState {
  const StartPageState();

  @override
  List<Object?> get props => [];
}

class DescriptionPageState extends NavigationState {
  final Film film;

  const DescriptionPageState({required this.film});

  @override
  List<Object?> get props => [film];
}

class ActorDetailsPageState extends NavigationState {
  final int actorId;
  final String profilePath;

  const ActorDetailsPageState(
      {required this.profilePath, required this.actorId});

  @override
  List<Object?> get props => [actorId, profilePath];
}

class ActorsListPageState extends NavigationState {
  final Film film;
  final int movieId;

  const ActorsListPageState({required this.movieId, required this.film});

  @override
  List<Object?> get props => [movieId, film];
}
