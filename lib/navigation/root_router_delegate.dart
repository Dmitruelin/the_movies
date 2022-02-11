import 'package:flutter/material.dart';
import 'package:the_movies/models/film.dart';
import 'package:the_movies/navigation/navigation_cubit.dart';
import 'package:the_movies/screens/animated_page.dart';
import 'package:the_movies/screens/description_screen.dart';
import 'package:the_movies/screens/start_screen.dart';

import '../screens/actor_detail_screen.dart';
import '../screens/actors_screen.dart';

class RootRouterDelegate extends RouterDelegate<NavigationState> {
  final GlobalKey<NavigatorState> _navigatorKey;
  final NavigationCubit _navigationCubit;

  RootRouterDelegate(
    this._navigatorKey,
    this._navigationCubit,
  );

  List<Page> pages = [AnimatedPage(child: const StartScreen(), path: '/home')];

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: _navigatorKey,
      pages: _extraPages(_navigationCubit.state),
      onPopPage: _onPopPage,
    );
  }

  void popExtra() {
    if (_navigationCubit.state is StartPageState) {
      _navigationCubit.goToStartPage();
    }

    if (_navigationCubit.state is DescriptionPageState) {
      _navigationCubit.goToStartPage();
    }

    if (_navigationCubit.state is ActorsListPageState) {
      _navigationCubit
          .goToDescriptionPage(_navigationCubit.state.props[1] as Film);
    }

    if (_navigationCubit.state is ActorDetailsPageState) {
      _navigationCubit.goToActorsPage(
          _navigationCubit.previousState.props[0] as int,
          _navigationCubit.previousState.props[1] as Film);
    }
  }

  bool _onPopPage(Route<dynamic> route, dynamic result) {
    if (!route.didPop(result) ||
        _navigationCubit.state == const StartPageState()) {
      return false;
    }
    popExtra();
    return true;
  }

  @override
  Future<bool> popRoute() async {
    return await _confirmAppExit();
  }

  List<Page> _extraPages(NavigationState state) {
    if (state is DescriptionPageState) {
      pages.add(
        AnimatedPage(
            child: DescriptionScreen(film: state.film), path: '/description'),
      );
    }

    if (state is ActorDetailsPageState) {
      pages.add(AnimatedPage(
        path: "/profile",
        child: ActorDetailsScreen(personId: state.actorId),
      ));
    }

    if (state is ActorsListPageState) {
      pages.add(AnimatedPage(
        path: "/list",
        child: ActorsScreen(movieId: state.movieId),
      ));
    }
    print(pages);
    return pages;
  }

  Future<bool> _confirmAppExit() async =>
      await showDialog<bool>(
          context: _navigatorKey.currentContext!,
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
