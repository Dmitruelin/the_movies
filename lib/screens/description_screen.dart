import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movies/models/film.dart';
import 'package:the_movies/navigation/navigation_cubit.dart';
import 'package:the_movies/utils/constants.dart';
import 'package:the_movies/utils/modified_english_text.dart';

import '../generated/l10n.dart';

class DescriptionScreen extends StatelessWidget {
  final Film film;

  const DescriptionScreen({
    Key? key,
    required this.film,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${film.name}'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          buildStack(context),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                ModifiedEnglishText(
                  text: S.of(context).overview,
                  size: ModifiedTextFontSize.large,
                  color: Colors.cyan,
                ),
                ModifiedEnglishText(
                  text: film.description!,
                  size: ModifiedTextFontSize.small,
                ),
                verticalIndent(),
                ElevatedButton(
                    child: ModifiedEnglishText(
                      text: 'Actors list',
                      size: ModifiedTextFontSize.medium,
                    ),
                    onPressed: () {
                      context
                          .read<NavigationCubit>()
                          .goToActorsPage(film.movieId, film);
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildStack(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          child: SizedBox(
            height: 300,
            width: MediaQuery.of(context).size.width,
          ),
        ),
        Positioned(
          child: SizedBox(
            height: 221,
            width: MediaQuery.of(context).size.width,
            child: Image.network(baseUrlForImages + film.bannerPath!),
          ),
        ),
        Positioned(
            left: 10,
            bottom: 0,
            child: SizedBox(
              height: 150,
              child: Hero(
                  tag: 'poster-image',
                  child: Image.network(baseUrlForImages + film.posterPath!)),
            )),
        Positioned(
          child: SizedBox(
            width: 250,
            child: ModifiedEnglishText(
              text: S.of(context).filmTitle + film.name!,
              size: 18,
            ),
          ),
          bottom: 35,
          right: 10,
        ),
        Positioned(
          child: SizedBox(
            width: 250,
            child: ModifiedEnglishText(
              text: S.of(context).startsOn + film.launchOn!,
              size: 18,
            ),
          ),
          bottom: 10,
          right: 10,
        ),
      ],
    );
  }
}
