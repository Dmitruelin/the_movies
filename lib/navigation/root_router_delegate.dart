import 'package:flutter/material.dart';
import 'package:the_movies/models/films.dart';
import 'package:the_movies/navigation/navigation_cubit.dart';
import 'package:the_movies/screens/actor_detail_screen.dart';
import 'package:the_movies/screens/actors_screen.dart';
import 'package:the_movies/screens/description_screen.dart';
import 'package:the_movies/screens/main_screen.dart';

class RootRouterDelegate extends RouterDelegate<NavigationState> {
  final GlobalKey<NavigatorState> _navigatorKey;
  final NavigationCubit _navigationCubit;

  RootRouterDelegate(
      GlobalKey<NavigatorState> navigatorKey, NavigationCubit navigationCubit)
      : _navigatorKey = navigatorKey,
        _navigationCubit = navigationCubit;

  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: List.from([
        _materialPage(valueKey: "Start Page", child: const StartPage()),
        ..._extraPages,
      ]),
      onPopPage: _onPopPage,
    );
  }

  bool _onPopPage(Route<dynamic> route, dynamic result) {
    _navigationCubit.clearState();
    return route.didPop(result);
  }

  @override
  Future<bool> popRoute() async {
    return await _confirmAppExit();
  }

  Page _materialPage({
    required String valueKey,
    required Widget child,
  }) =>
      MaterialPage(
        key: ValueKey<String>(valueKey),
        child: child,
      );

  List<Page> get _extraPages {
    if (_navigationCubit.state is DescriptionPageState) {
      Films film;
      film = (_navigationCubit.state as DescriptionPageState).film;
      return [
        _materialPage(
          valueKey: "Description Page",
          child: Description(film: film),
        ),
      ];
    }

    if (_navigationCubit.state is ActorDetailsPageState) {
      int actorId;
      actorId = (_navigationCubit.state as ActorDetailsPageState).actorId;
      return [
        _materialPage(
          valueKey: "Actor's Profile Page",
          child: ActorDetailsPage(
            actorId: actorId,
          ),
        ),
      ];
    }

    if (_navigationCubit.state is ActorsListPageState) {
      int movieId;
      movieId = (_navigationCubit.state as ActorsListPageState).movieId;
      return [
        _materialPage(
          valueKey: "Actors List Page",
          child: ActorsScreen(movieId: movieId),
        ),
      ];
    }
    return [];
  }

  Future<bool> _confirmAppExit() async =>
      await showDialog<bool>(
          context: navigatorKey.currentContext!,
          builder: (context) {
            return AlertDialog(
              title: const Text("Exit App"),
              content: const Text("Are you sure you want to exit the app?"),
              actions: [
                TextButton(
                  child: const Text("Confirm"),
                  onPressed: () => Navigator.pop(context, false),
                ),
                TextButton(
                  child: const Text("Cancel"),
                  onPressed: () => Navigator.pop(context, true),
                ),
              ],
            );
          }) ??
      true;

//It's not needed for cubit
  @override
  void addListener(VoidCallback listener) {}

//It's not needed for cubit
  @override
  void removeListener(VoidCallback listener) {}

  @override
  Future<void> setNewRoutePath(NavigationState configuration) async {}
}
