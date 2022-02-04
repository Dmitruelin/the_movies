import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movies/bloc/actors/actors_list_cubit.dart';
import 'package:the_movies/models/film.dart';
import 'package:the_movies/navigation/navigation_cubit.dart';
import 'package:the_movies/utils/constants.dart';
import 'package:the_movies/utils/modified_text.dart';

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
                ModifiedText(
                  text: 'Overview',
                  size: ModifiedTextFontSize.large,
                  color: Colors.cyan,
                ),
                ModifiedText(
                  text: film.description!,
                  size: ModifiedTextFontSize.small,
                ),
                verticalIndent(),
                ElevatedButton(
                    child: ModifiedText(
                      text: 'Actors list',
                      size: ModifiedTextFontSize.medium,
                    ),
                    onPressed: () {
                      context
                          .read<ActorsListCubit>()
                          .getActorsList(film.movieId);
                      context
                          .read<NavigationCubit>()
                          .goToActorsPage(movieId: film.movieId);
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
    );
  }
}

class FilmDetailsPage extends Page {
  final Film film;

  FilmDetailsPage({
    required this.film,
  }) : super(key: ValueKey(film.id));

  @override
  Route createRoute(BuildContext context) {
    return PageRouteBuilder(
      transitionDuration: const Duration(seconds: 3),
      settings: this,
      pageBuilder: (context, animation, animation2) {
        final tween = Tween(begin: const Offset(0.0, 1.0), end: Offset.zero);
        final curveTween = CurveTween(curve: Curves.easeInOut);
        return SlideTransition(
          position: animation.drive(curveTween).drive(tween),
          child: DescriptionScreen(
            key: ValueKey(film.id),
            film: film,
          ),
        );
      },
    );
  }
}
