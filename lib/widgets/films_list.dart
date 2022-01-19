import 'package:flutter/material.dart';
import 'package:the_movies/screens/description_screen.dart';
import 'package:the_movies/utils/credentials.dart';
import 'package:the_movies/utils/modified_text.dart';

class FilmsList extends StatelessWidget {
  final List nowPlayingMovies;

  const FilmsList({Key? key, required this.nowPlayingMovies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          const SizedBox(height: 10,),
          SizedBox(
            height: 370,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: nowPlayingMovies.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    hoverColor: Colors.blue,
                    enableFeedback: true,
                    excludeFromSemantics: true,
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Description(
                                    name: nowPlayingMovies[index]['title'],
                                    launchOn: nowPlayingMovies[index]
                                        ['release_date'],
                                    description: nowPlayingMovies[index]
                                        ['overview'],
                                    bannerPath: nowPlayingMovies[index]
                                        ['backdrop_path'],
                                    posterPath: nowPlayingMovies[index]
                                        ['poster_path'],
                                    movieId: nowPlayingMovies[index]['id'],
                                  )));
                    },
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 1.4,
                      child: Container(
                        height: 240,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                                baseUrl +
                                    nowPlayingMovies[index]['poster_path']),
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
  }
}
