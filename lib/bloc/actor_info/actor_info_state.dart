part of 'actor_info_cubit.dart';

abstract class ActorInfoState extends Equatable {
  const ActorInfoState();
}

class ActorInfoInitial extends ActorInfoState {
  @override
  List<Object> get props => [];
}

class ActorInfoLoadingState extends ActorInfoState {
  @override
  List<Object> get props => [];
}

class ActorInfoLoadedState extends ActorInfoState {
  final Actor actor;

  const ActorInfoLoadedState(this.actor);

  @override
  List<Object> get props => [actor];
}

class ErrorState extends ActorInfoState {
  @override
  List<Object> get props => [];
}
