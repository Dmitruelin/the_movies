import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movies/bloc/actor_info/actor_info_cubit.dart';
import 'package:the_movies/bloc/actors/actors_list_cubit.dart';
import 'package:the_movies/screens/actor_detail_screen.dart';
import 'package:the_movies/utils/constants.dart';
import 'package:the_movies/utils/modified_text.dart';
import 'package:the_movies/utils/photo_hero.dart';

class ActorsScreen extends StatelessWidget {
  const ActorsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // This is for Hero Animation
    timeDilation = 2.0;

    return Scaffold(
      appBar: AppBar(
        title: const Icon(Icons.people),
        centerTitle: true,
        elevation: 4,
      ),
      body: BlocBuilder<ActorsListCubit, List>(builder: (context, actors) {
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
                  trailing: Icon(
                      actors[index]['gender'] == 2 ? Icons.male : Icons.female),
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
