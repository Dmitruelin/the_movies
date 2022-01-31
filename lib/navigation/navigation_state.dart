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
  final Films film;

  const DescriptionPageState({required this.film});

  @override
  List<Object?> get props => [film];
}

class ActorDetailsPageState extends NavigationState {
  final int actorId;
  const ActorDetailsPageState({required this.actorId});

  @override
  List<Object?> get props => [];
}

class ActorsListPageState extends NavigationState {
  final int movieId;

  const ActorsListPageState({required this.movieId});

  @override
  List<Object?> get props => [movieId];
}

class ClearState extends NavigationState {
  const ClearState();

  @override
  List<Object?> get props => [];
}
