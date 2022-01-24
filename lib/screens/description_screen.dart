import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movies/bloc/actors/actors_cubit.dart';
import 'package:the_movies/models/films.dart';
import 'package:the_movies/screens/actors_screen.dart';
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
        title: Text('Details of $film'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                Positioned(
                  child: SizedBox(
                    height: 350,
                    width: MediaQuery.of(context).size.width,
                    child: Image.network(baseUrl + film.bannerPath!),
                  ),
                ),
                Positioned(
                    left: 10,
                    bottom: 0,
                    child: SizedBox(
                      height: 150,
                      child: Image.network(baseUrl + film.posterPath!),
                    )),
                Positioned(
                  child: SizedBox(
                    width: 250,
                    child: ModifiedText(
                      text: 'Title: ' + film.name!,
                      size: 18,
                    ),
                  ),
                  bottom: 25,
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
                  bottom: 6,
                  right: 10,
                ),
              ],
            ),
            const ModifiedText(
              text: 'Overview',
              size: 24,
              color: Colors.cyan,
            ),
            ModifiedText(text: film.description!),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                child: const Text('Actors list'),
                onPressed: () {
                  film.isActorsNeed = !film.isActorsNeed;
                  BlocProvider.of<ActorsCubit>(context)
                      .getActorsList(film.movieId!);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ActorsScreen()));
                }),
          ],
        ),
      ),
    );
  }
}
