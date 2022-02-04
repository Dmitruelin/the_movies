import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movies/bloc/actor_info/actor_info_cubit.dart';
import 'package:the_movies/screens/actor_detail_screen.dart';
import 'package:the_movies/utils/constants.dart';
import 'package:the_movies/utils/data_service_transition.dart';
import 'package:the_movies/utils/modified_text.dart';
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
      body: FutureBuilder(
          future: context
              .read<DataServiceTransition>()
              .dataService
              .getActorsList(movieId),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }
            final List actors = snapshot.requireData as List;

            return GridView.builder(
              itemCount: actors.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    PhotoHero(
                      photo: (actors[index]['profile_path'] != null)
                          ? (baseUrlForImages + actors[index]['profile_path'])
                          : unknownActorPhoto,
                      onTap: (actors[index]['profile_path'] != null)
                          ? () {
                              context
                                  .read<ActorInfoCubit>()
                                  .getActorPersonalInfo(actors[index]['id']);
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      const ActorDetailsScreen()));
                            }
                          : () {},
                      height: 120,
                      width: 200,
                    ),
                    ListTile(
                      trailing: Icon(actors[index]['gender'] == 2
                          ? Icons.male
                          : Icons.female),
                      title: ModifiedText(
                        text: (actors[index]['name']) ?? 'Unknown actor',
                        size: ModifiedTextFontSize.medium,
                      ),
                      onTap: () {
                        context
                            .read<ActorInfoCubit>()
                            .getActorPersonalInfo(actors[index]['id']);
                      },
                    ),
                  ],
                );
              },
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
            );
          }),
    );
  }
}
