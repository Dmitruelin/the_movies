import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movies/bloc/now_playing/now_playing_cubit.dart';
import 'package:the_movies/bloc/popular/popular_cubit.dart';
import 'package:the_movies/navigation/app_navigation.dart';
import 'package:the_movies/navigation/navigation_cubit.dart';
import 'package:the_movies/screens/actors_screen.dart';
import 'package:the_movies/widgets/films_list.dart';
import 'package:the_movies/widgets/popular_films.dart';

import 'bloc/actors/actors_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MultiBlocProvider(
        providers: [
          BlocProvider<NowPlayingCubit>(
              create: (_) => NowPlayingCubit()..getFilms(),
              child: const FilmsList()),
          BlocProvider<PopularCubit>(
              create: (_) => PopularCubit()..getPopularFilms(),
              child: const PopularFilms()),
          BlocProvider<ActorsCubit>(
            create: (_) => ActorsCubit(),
            child: const ActorsScreen(),
          ),
          BlocProvider<NavigationCubit>(create: (_) => NavigationCubit()),
        ],
        child: const AppNavigation(),
      ),
    );
  }
}
