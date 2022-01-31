import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movies/bloc/actor_info/actor_info_cubit.dart';
import 'package:the_movies/bloc/actors/actors_list_cubit.dart';
import 'package:the_movies/bloc/now_playing/get_films_cubit.dart';
import 'package:the_movies/navigation/navigation_cubit.dart';
import 'package:the_movies/navigation/root_router_delegate.dart';
import 'package:the_movies/theme/theme_cubit.dart';
import 'package:the_movies/utils/data_service_implementation.dart';

void main() {
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
            theme: theme,
            home: BlocBuilder<NavigationCubit, NavigationState>(
              builder: (context, state) => Router(
                routerDelegate: RootRouterDelegate(GlobalKey<NavigatorState>(),
                    context.read<NavigationCubit>()),
                backButtonDispatcher: RootBackButtonDispatcher(),
              ),
            ),
          );
        },
      ),
    );
  }
}
