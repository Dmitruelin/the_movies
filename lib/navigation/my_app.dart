import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movies/bloc/get_films/get_popular_films_cubit.dart';
import 'package:the_movies/main.dart';
import 'package:the_movies/navigation/root_router_delegate.dart';
import 'package:the_movies/navigation/root_router_information_parser.dart';

import '../bloc/get_films/get_now_playing_films_cubit.dart';
import '../theme/theme_cubit.dart';
import '../utils/data_service.dart';
import 'navigation_cubit.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NavigationCubit>(create: (_) => NavigationCubit()),
        BlocProvider<ThemeCubit>(create: (_) => ThemeCubit()),
        BlocProvider<GetFilmsCubit>(
            create: (_) => GetFilmsCubit(getIt.get<DataService>())..getFilms()),
        BlocProvider<GetPopularFilms>(
            create: (_) =>
                GetPopularFilms(getIt.get<DataService>())..getPopularFilms()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeData>(
        builder: (context, theme) {
          return MaterialApp.router(
            routerDelegate: RootRouterDelegate(
                GlobalKey<NavigatorState>(), context.watch<NavigationCubit>()),
            debugShowCheckedModeBanner: false,
            theme: theme,
            routeInformationParser: RootRouteInformationParser(),
          );
        },
      ),
    );
  }
}
