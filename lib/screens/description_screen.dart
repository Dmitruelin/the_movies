import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movies/bloc/actors/actors_list_cubit.dart';
import 'package:the_movies/models/films.dart';
import 'package:the_movies/navigation/navigation_cubit.dart';
import 'package:the_movies/utils/credentials.dart';
import 'package:the_movies/utils/modified_text.dart';

class Description extends StatelessWidget {
  final Films film;

  const Description({
    Key? key,
    required this.film,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details of ${film.name}'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Stack(
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
                          child: Image.network(
                              baseUrlForImages + film.posterPath!)),
                    )),
                Positioned(
                  child: SizedBox(
                    width: 250,
                    child: ModifiedText(
                      text: 'Title: ' + film.name!,
                      size: 18,
                    ),
                  ),
                  bottom: 35,
                  right: 10,
                ),
                Positioned(
                  child: SizedBox(
                    width: 250,
                    child: ModifiedText(
                      text: 'Starts on: ' + film.launchOn!,
                      size: 18,
                    ),
                  ),
                  bottom: 10,
                  right: 10,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const ModifiedText(
                  text: 'Overview',
                  size: 24,
                  color: Colors.cyan,
                ),
                ModifiedText(
                  text: film.description!,
                  size: 16,
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    child: const ModifiedText(
                      text: 'Actors list',
                      size: 16,
                    ),
                    onPressed: () {
                      context
                          .read<ActorsListCubit>()
                          .getActorsList(film.movieId!);
                      context
                          .read<NavigationCubit>()
                          .goToActorsPage(movieId: film.movieId!);
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
