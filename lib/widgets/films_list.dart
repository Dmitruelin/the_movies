import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movies/bloc/now_playing/now_playing_cubit.dart';
import 'package:the_movies/models/films.dart';
import 'package:the_movies/navigation/navigation_cubit.dart';
import 'package:the_movies/utils/credentials.dart';
import 'package:the_movies/utils/modified_text.dart';

class FilmsList extends StatelessWidget {
  const FilmsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NowPlayingCubit, List<Films>>(
        builder: (context, filmsList) {
      if (filmsList.isEmpty) {
        return const Center(child: CircularProgressIndicator());
      }
      return Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ModifiedText(
              text: 'Now playing',
              size: 26.0,
              color: Colors.white,
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 370,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: filmsList.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () => BlocProvider.of<NavigationCubit>(context)
                          .showDetailsOfFilm(filmsList[index]),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 1.4,
                        child: Container(
                          height: 240,
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
