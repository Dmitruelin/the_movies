import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movies/bloc/now_playing/get_films_cubit.dart';
import 'package:the_movies/models/film.dart';
import 'package:the_movies/navigation/navigation_cubit.dart';
import 'package:the_movies/theme/theme_cubit.dart';
import 'package:the_movies/utils/credentials.dart';
import 'package:the_movies/utils/modified_text.dart';

class PopularFilms extends StatelessWidget {
  const PopularFilms({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetFilmsCubit, List<Film>>(
        builder: (context, filmsList) {
      if (filmsList.isEmpty) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      return Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ModifiedText.withShadows(
              text: 'Popular',
              size: 26.0,
              color: (context.read<ThemeCubit>().state.brightness ==
                      Brightness.light)
                  ? Colors.amberAccent
                  : Colors.white,
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 200,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: filmsList.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () => BlocProvider.of<NavigationCubit>(context)
                          .goToDescriptionPage(filmsList[index]),
                      child: SizedBox(
                        width: 140,
                        child: Image.network(
                            baseUrlForImages + filmsList[index].posterPath!),
                      ),
                    );
                  }),
            ),
          ],
        ),
      );
    });
  }
}
