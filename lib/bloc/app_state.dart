part of 'app_cubit.dart';

abstract class ScreenState extends Equatable {
  const ScreenState();

  @override
  List<Object?> get props => [];
}

class StartScreenState extends ScreenState {
  final String? extraPageContent;

  const StartScreenState({this.extraPageContent});

  @override
  List<Object?> get props => [extraPageContent];
}

class ActorsScreenState extends ScreenState {
  final String? extraPageContent;

  const ActorsScreenState({required this.extraPageContent});

  @override
  List<Object?> get props => [extraPageContent];
}

class DescriptionScreenState extends ScreenState {
  final String name, launchOn, description, bannerPath, posterPath;
  final int movieId;

  const DescriptionScreenState(
      {required this.movieId,
      required this.description,
      required this.launchOn,
      required this.posterPath,
      required this.bannerPath,
      required this.name});

  @override
  List<Object?> get props => [name, launchOn, description, bannerPath, posterPath, movieId];
}
