import 'package:flutter/material.dart';
import 'package:the_movies/utils/credentials.dart';
import 'package:the_movies/utils/modified_text.dart';

class PopularFilms extends StatelessWidget {
  final List popularMovies;

  const PopularFilms({
    Key? key,
    required this.popularMovies,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                itemCount: popularMovies.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {},
                    child: SizedBox(
                      width: 140,
                      child: Container(
                        height: 140,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(baseUrl +
                                popularMovies[index]['poster_path']),
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
