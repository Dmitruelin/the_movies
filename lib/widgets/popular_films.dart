import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movies/bloc/get_films/get_popular_films_cubit.dart';
import 'package:the_movies/models/film.dart';
import 'package:the_movies/theme/theme_cubit.dart';
import 'package:the_movies/utils/constants.dart';
import 'package:the_movies/utils/modified_text.dart';

import '../navigation/navigation_cubit.dart';

class PopularFilms extends StatelessWidget {
  const PopularFilms({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetPopularFilms, List<Film>>(
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
              size: ModifiedTextFontSize.large,
              color: (context.read<ThemeCubit>().state.brightness ==
                      Brightness.light)
                  ? Colors.amberAccent
                  : Colors.white,
            ),
            verticalIndent(),
            SizedBox(
              height: 200,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: filmsList.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () => context
                          .read<NavigationCubit>()
                          .goToDescriptionPage(filmsList[index]),
                      child: Card(
                        elevation: 10,
                        shadowColor: Colors.amberAccent,
                        margin: const EdgeInsets.symmetric(horizontal: 15),
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
