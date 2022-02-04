import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movies/bloc/get_films/get_films_cubit.dart';
import 'package:the_movies/models/film.dart';
import 'package:the_movies/navigation/navigation_cubit.dart';
import 'package:the_movies/screens/description_screen.dart';
import 'package:the_movies/utils/constants.dart';

class MovieSearch extends SearchDelegate {
  late Film film;

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          if (query.isEmpty) {
            close(context, null);
          } else {
            query = '';
          }
        },
        icon: const Icon(Icons.close),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {}

  @override
  Widget buildResults(BuildContext context) {
    return DescriptionScreen(film: film);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return BlocBuilder<GetFilmsCubit, List<Film>>(
        builder: (context, filmsList) {
      final filmsListSuggestion = query.isEmpty
          ? filmsList
          : filmsList.where((element) {
              final queryLowerCase = query.toLowerCase();
              final filmNameLowerCase = element.name.toString().toLowerCase();

              return filmNameLowerCase.contains(queryLowerCase);
            }).toList();
      if (filmsList.isEmpty) return const CircularProgressIndicator();

      return buildSuggestionsSuccess(filmsListSuggestion);
    });
  }

  Widget buildSuggestionsSuccess(List<Film> filmList) {
    List filmsList = filmList.toList();
    return ListView.builder(
        itemCount: filmsList.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 4,
            margin: const EdgeInsets.all(8),
            shadowColor: Colors.blue,
            child: ListTile(
              onTap: () => BlocProvider.of<NavigationCubit>(context)
                  .goToDescriptionPage(filmsList[index]),
              title: Text(filmsList[index].name!),
              leading: Image.network(
                  baseUrlForImages + filmsList[index].posterPath!),
            ),
          );
        });
  }
}
