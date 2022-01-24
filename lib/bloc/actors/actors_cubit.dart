import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movies/utils/data_service.dart';

class ActorsCubit extends Cubit<List> {
  final _dataService = DataService();

  ActorsCubit() : super([]);

  void getActorsList(int movieId) async =>
      emit(await _dataService.getActorsForFilm(movieId));
}
