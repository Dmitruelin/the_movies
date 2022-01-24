import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movies/bloc/popular/popular_cubit.dart';
import 'package:the_movies/models/films.dart';
import 'package:the_movies/navigation/navigation_cubit.dart';
import 'package:the_movies/utils/credentials.dart';
import 'package:the_movies/utils/modified_text.dart';

class PopularFilms extends StatelessWidget {
  const PopularFilms({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PopularCubit, List<Films>>(
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
            const ModifiedText(
              text: 'Popular',
              size: 26.0,
              color: Colors.black,
            ),
            SizedBox(
              height: 200,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: filmsList.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () => BlocProvider.of<NavigationCubit>(context)
                          .showDetailsOfFilm(filmsList[index]),
                      child: SizedBox(
                        width: 140,
                        child: Container(
                          height: 140,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                  baseUrl + filmsList[index].posterPath!),
                            ),
                          ),
                        ),
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
