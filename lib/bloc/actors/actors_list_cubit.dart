import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movies/utils/data_service.dart';

class ActorsListCubit extends Cubit<List> {
  final DataService _dataService;

  DataService get dataService => _dataService;

  ActorsListCubit(this._dataService) : super([]);

  void getActorsList(int movieId) async =>
      emit(await dataService.getActorsList(movieId));
}
