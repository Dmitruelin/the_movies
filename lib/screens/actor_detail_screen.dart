import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:the_movies/bloc/actor_info/actor_info_cubit.dart';
import 'package:the_movies/models/actor.dart';
import 'package:the_movies/theme/theme_cubit.dart';
import 'package:the_movies/utils/constants.dart';
import 'package:the_movies/utils/modified_text.dart';
import 'package:the_movies/utils/photo_hero.dart';

class ActorDetailsScreen extends StatelessWidget {
  const ActorDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile screen'),
        centerTitle: true,
      ),
      body: BlocBuilder<ActorInfoCubit, ActorInfoState>(
          builder: (context, state) {
        if (state is ActorInfoLoadingState) {
          return const CircularProgressIndicator();
        }
        if (state is ActorInfoLoadedState) {
          final Actor actor = state.actor;
          return ListView(
            children: [
              SizedBox(
                height: 300,
                child: PhotoHero(
                  onTap: () => Navigator.pop(context),
                  height: 250,
                  width: MediaQuery.of(context).size.width,
                  photo: baseUrlForImages + actor.profilePath,
                ),
              ),
              Row(children: [
                const ModifiedText.withShadows(
                  text: 'Name :  ',
                  size: 19,
                ),
                Text('${actor.name}',
                    style: GoogleFonts.adamina(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: (context.read<ThemeCubit>().state.brightness ==
                                Brightness.light)
                            ? Colors.blueGrey
                            : Colors.lightGreen)),
              ]),
              verticalIndent(),
              RichText(
                  text: TextSpan(children: <TextSpan>[
                TextSpan(
                  text: 'Biography : ',
                  style: GoogleFonts.breeSerif(
                    fontSize: 19,
                    height: 0.9,
                    shadows: <Shadow>[
                      const Shadow(
                        offset: Offset(1.0, 1.0),
                        blurRadius: 3.0,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                      const Shadow(
                        offset: Offset(1.0, 1.0),
                        blurRadius: 8.0,
                        color: Color.fromARGB(125, 0, 0, 255),
                      ),
                    ],
                  ),
                ),
                TextSpan(
                    text: '${actor.biography}',
                    style: GoogleFonts.adamina(
                        fontSize: 15,
                        color: (context.read<ThemeCubit>().state.brightness ==
                                Brightness.light)
                            ? Colors.blueGrey
                            : Colors.lightGreen)),
              ])),
              verticalIndent(),
              if (actor.birthDay != null)
                ModifiedText(text: 'Date of birth : ${actor.birthDay}'),
              verticalIndent(),
              if (actor.deathDay != null)
                ModifiedText(text: 'Date of death : ${actor.deathDay}'),
              verticalIndent(),
            ],
          );
        }
        if (state is ErrorState) {
          return const Icon(Icons.close);
        } else {
          return Container();
        }
      }),
    );
  }
}
