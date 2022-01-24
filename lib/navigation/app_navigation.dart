import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movies/models/films.dart';
import 'package:the_movies/navigation/navigation_cubit.dart';
import 'package:the_movies/screens/actors_screen.dart';
import 'package:the_movies/screens/description_screen.dart';
import 'package:the_movies/screens/main_screen.dart';

class AppNavigation extends StatelessWidget {
  const AppNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, Films?>(
        builder: ((context, film) => Navigator(
              pages: [
                MaterialPage(child: StartPage()),
                if (film?.isActorsNeed == true)
                  const MaterialPage(child: ActorsScreen()),
                if (film != null) MaterialPage(child: Description(film: film)),
              ],
              onPopPage: (route, result) {
                if (!route.didPop(result)) return false;
                return true;
              },
            )));
  }
}
