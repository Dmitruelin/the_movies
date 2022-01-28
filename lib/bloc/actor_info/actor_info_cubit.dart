import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movies/models/actor.dart';
import 'package:the_movies/utils/data_service.dart';

part 'actor_info_state.dart';

class ActorInfoCubit extends Cubit<ActorInfoState> {
  final DataService _dataService;

  DataService get dataService => _dataService;

  ActorInfoCubit(this._dataService) : super(ActorInfoInitial());

  void getActorPersonalInfo(int personId) async {
    try {
      final actor = await dataService.getActorPersonInfo(personId);
      emit(ActorInfoLoadedState(actor));
    } catch (e) {
      emit(ErrorState());
    }
  }
}
