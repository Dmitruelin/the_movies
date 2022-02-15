import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movies/bloc/get_films/get_now_playing_films_cubit.dart';
import 'package:the_movies/models/film.dart';
import 'package:the_movies/utils/constants.dart';

import '../navigation/navigation_cubit.dart';

class FilmsList extends StatelessWidget {
  const FilmsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetFilmsCubit, List<Film>>(
        builder: (context, filmsList) {
      if (filmsList.isEmpty) {
        return const Center(child: CircularProgressIndicator());
      }
      return Container(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 370,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: filmsList.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () => context
                      .read<NavigationCubit>()
                      .goToDescriptionPage(filmsList[index]),
                  child: Card(
                    margin: const EdgeInsets.symmetric(horizontal: 28),
                    elevation: 20,
                    shadowColor: Colors.amberAccent,
                    child: Image.network(
                        baseUrlForImages + filmsList[index].posterPath!),
                  ),
                );
              }),
        ),
      );
    });
  }
}
