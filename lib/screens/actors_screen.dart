import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movies/bloc/actors/actors_list_cubit.dart';
import 'package:the_movies/main.dart';
import 'package:the_movies/navigation/navigation_cubit.dart';
import 'package:the_movies/utils/constants.dart';
import 'package:the_movies/utils/data_service.dart';
import 'package:the_movies/utils/modified_english_text.dart';
import 'package:the_movies/utils/photo_hero.dart';

class ActorsScreen extends StatelessWidget {
  final int movieId;
  const ActorsScreen({Key? key, required this.movieId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Icon(Icons.people),
        centerTitle: true,
        elevation: 4,
      ),
      body: BlocProvider<ActorsListCubit>(
        create: (_) => ActorsListCubit(getIt.get<DataService>())
          ..getActorsList(movieId: movieId),
        child: BlocBuilder<ActorsListCubit, List>(builder: (context, actors) {
          return GridView.builder(
            itemCount: actors.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  SizedBox(
                    height: 120,
                    child: PhotoHero(
                      photo: (actors[index]['profile_path'] != null)
                          ? (baseUrlForImages + actors[index]['profile_path'])
                          : unknownActorPhoto,
                      onTap: (actors[index]['profile_path'] != null)
                          ? () {
                              context
                                  .read<NavigationCubit>()
                                  .goToActorsDetailsPage(
                                    actors[index]['id'],
                                  );
                            }
                          : () {},
                      width: 200,
                    ),
                  ),
                  ListTile(
                    trailing: Icon(actors[index]['gender'] == 2
                        ? Icons.male
                        : Icons.female),
                    title: ModifiedEnglishText(
                      text: (actors[index]['name']) ?? 'Unknown actor',
                      size: ModifiedTextFontSize.medium,
                    ),
                  ),
                ],
              );
            },
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
          );
        }),
      ),
    );
  }
}
