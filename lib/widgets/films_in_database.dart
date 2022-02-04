import 'package:flutter/material.dart';
import 'package:the_movies/main.dart';
import 'package:the_movies/models/film.dart';
import 'package:the_movies/models/film_dao.dart';
import 'package:the_movies/screens/description_screen.dart';
import 'package:the_movies/utils/constants.dart';
import 'package:the_movies/utils/custom_page_route.dart';
import 'package:the_movies/utils/modified_text.dart';

class FilmsListFromDatabase extends StatelessWidget {
  const FilmsListFromDatabase({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dao = getIt.get<FilmDao>();
    return StreamBuilder<List<Film>>(
        stream: dao.findAllFilmsAsStream(),
        builder: (_, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final films = snapshot.requireData;

          return Container(
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ModifiedText.withShadows(
                    text: 'Movies from DataBase',
                    size: ModifiedTextFontSize.medium,
                    color: Colors.white,
                  ),
                  verticalIndent(),
                  SizedBox(
                    height: 270,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: films.length,
                        itemBuilder: (_, index) {
                          return InkWell(
                            enableFeedback: true,
                            customBorder: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  CustomPageRoute(
                                      child: DescriptionScreen(
                                          film: films[index])));
                            },
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width / 1.8,
                              child: Image.network(
                                  baseUrlForImages + films[index].posterPath!),
                            ),
                          );
                        }),
                  ),
                ],
              ));
        });
  }
}
