import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movies/bloc/actors/actors_list_cubit.dart';
import 'package:the_movies/main.dart';
import 'package:the_movies/screens/actor_detail_screen.dart';
import 'package:the_movies/utils/constants.dart';
import 'package:the_movies/utils/data_service.dart';
import 'package:the_movies/utils/modified_text.dart';
import 'package:the_movies/utils/photo_hero.dart';

import '../generated/l10n.dart';

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
                    child: (actors[index]['profile_path'] != null)
                        ? PhotoHero(
                            photo: (baseUrlForImages +
                                actors[index]['profile_path']),
                            onTap: () =>
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => ActorDetailsScreen(
                                          personId: (actors[index]['id']),
                                          posterPath: actors[index]
                                              ['profile_path'],
                                        ))),
                            width: 200,
                          )
                        : Image.network(unknownActorPhoto),
                  ),
                  ListTile(
                    trailing: Icon(actors[index]['gender'] == 2
                        ? Icons.male
                        : Icons.female),
                    title: ModifiedText(
                      text:
                          (actors[index]['name']) ?? S.of(context).unknownActor,
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
