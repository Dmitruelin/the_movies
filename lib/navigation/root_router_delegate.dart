import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movies/navigation/navigation_cubit.dart';
import 'package:the_movies/screens/description_screen.dart';
import 'package:the_movies/screens/start_screen.dart';
import 'package:the_movies/utils/animated_page.dart';

import '../models/film.dart';
import '../screens/actor_detail_screen.dart';
import '../screens/actors_screen.dart';

class RootRouterDelegate extends RouterDelegate<NavigationState> {
  final GlobalKey<NavigatorState> _navigatorKey;

  RootRouterDelegate(
    this._navigatorKey,
  );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, NavigationState>(
      builder: (context, state) => Navigator(
          key: _navigatorKey,
          pages: _extraPages(state),
          onPopPage: (route, result) {
            NavigationCubit cubit = context.read<NavigationCubit>();
            if (!route.didPop(result)) return false;
            popExtra(cubit);
            return true;
          }),
    );
  }

  List<Page> _extraPages(NavigationState state) {
    List<Page> pages = [
      AnimatedPage(child: const StartScreen(), path: '/home'),
    ];

    if (state is DescriptionPageState) {
      pages.add(AnimatedPage(
          child: DescriptionScreen(film: state.film),
          path: '/description',
          args: {'filmTitle': state.film.name}));
    }

    if (state is ActorDetailsPageState) {
      pages.add(AnimatedPage(
        path: "/profile",
        child: ActorDetailsScreen(
          personId: state.actorId,
          posterPath: state.profilePath,
        ),
      ));
    }

    if (state is ActorsListPageState) {
      pages.add(AnimatedPage(
        path: "/list",
        child: ActorsScreen(movieId: state.movieId),
      ));
    }

    return pages;
  }

  void popExtra(NavigationCubit cubit) {
    if (cubit.state is DescriptionPageState) {
      cubit.goToStartPage();
    }

    if (cubit.state is ActorsListPageState) {
      cubit.goToDescriptionPage(cubit.state.props[1] as Film);
    }

    if (cubit.state is ActorDetailsPageState) {
      cubit.goToActorsPage(cubit.previousState.props[0] as int,
          cubit.previousState.props[1] as Film);
    }
  }

  @override
  Future<bool> popRoute() async {
    return await _confirmAppExit();
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
