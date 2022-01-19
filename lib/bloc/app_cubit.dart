import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_state.dart';

class ScreensCubit extends Cubit<ScreenState> {
  ScreensCubit() : super(const StartScreenState());

  void goToDescription([String? posterPath, bannerPath,  description, launchOn, name, int? movieId]) => emit (DescriptionScreenState(posterPath: posterPath!, bannerPath: bannerPath, description: description, launchOn: launchOn,name: name, movieId: movieId! ));

  void goToStartPage([String? text]) => emit (StartScreenState(extraPageContent: text));

  void goToActorsPage([String? text]) => emit (ActorsScreenState(extraPageContent: text));

  void popExtra() {
    if (state is DescriptionScreenState) {
      goToDescription();
    } else if (state is ActorsScreenState) {
      goToActorsPage();
    } else {
      goToStartPage();
    }
  }
}