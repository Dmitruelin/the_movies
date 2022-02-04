import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:the_movies/bloc/actor_info/actor_info_cubit.dart';
import 'package:the_movies/bloc/actors/actors_list_cubit.dart';
import 'package:the_movies/models/film_dao.dart';
import 'package:the_movies/navigation/navigation_cubit.dart';
import 'package:the_movies/navigation/root_router_delegate.dart';
import 'package:the_movies/theme/theme_cubit.dart';
import 'package:the_movies/utils/data_service_implementation.dart';

import 'bloc/get_films/get_films_cubit.dart';
import 'database/database.dart';

GetIt getIt = GetIt.instance;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final database =
      await $FloorAppDatabase.databaseBuilder('flutter_database.db').build();
  final dao = database.filmDao;
  getIt.registerSingleton<FilmDao>(dao);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NavigationCubit>(create: (_) => NavigationCubit()),
        BlocProvider<GetFilmsCubit>(
            create: (_) => GetFilmsCubit(DataServiceImplementation())
              ..getFilms()
              ..getPopularFilms()),
        BlocProvider<ThemeCubit>(create: (_) => ThemeCubit()),
        BlocProvider<ActorsListCubit>(
          create: (_) => ActorsListCubit(DataServiceImplementation()),
        ),
        BlocProvider<ActorInfoCubit>(
            create: (_) => ActorInfoCubit(DataServiceImplementation())),
      ],
      child: BlocBuilder<ThemeCubit, ThemeData>(
        builder: (context, theme) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: theme,
            home: BlocBuilder<NavigationCubit, NavigationState>(
              builder: (context, state) => Router(
                routerDelegate: RootRouterDelegate(
                  GlobalKey<NavigatorState>(),
                  context.read<NavigationCubit>(),
                ),
                backButtonDispatcher: RootBackButtonDispatcher(),
              ),
            ),
          );
        },
      ),
    );
  }
}
