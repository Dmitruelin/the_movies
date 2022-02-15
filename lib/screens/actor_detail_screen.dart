import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:the_movies/bloc/actor_info/actor_info_cubit.dart';
import 'package:the_movies/main.dart';
import 'package:the_movies/models/actor.dart';
import 'package:the_movies/theme/theme_cubit.dart';
import 'package:the_movies/utils/constants.dart';
import 'package:the_movies/utils/data_service.dart';
import 'package:the_movies/utils/modified_english_text.dart';
import 'package:the_movies/utils/photo_hero.dart';

class ActorDetailsScreen extends StatelessWidget {
  final int personId;

  const ActorDetailsScreen({Key? key, required this.personId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile screen'),
        centerTitle: true,
      ),
      body: BlocProvider<ActorInfoCubit>(
        create: (context) => ActorInfoCubit(getIt.get<DataService>())
          ..getActorPersonalInfo(personId),
        child: BlocBuilder<ActorInfoCubit, ActorInfoState>(
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
                    width: MediaQuery.of(context).size.width,
                    photo: baseUrlForImages + actor.profilePath,
                  ),
                ),
                Row(children: [
                  const ModifiedEnglishText.withShadows(
                    text: 'Name :  ',
                    size: 19,
                  ),
                  Text('${actor.name}',
                      style: GoogleFonts.adamina(
                          fontSize: ModifiedTextFontSize.medium,
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
                      fontSize: ModifiedTextFontSize.medium,
                      height: 0.9,
                    ),
                  ),
                  TextSpan(
                      text: '${actor.biography}',
                      style: GoogleFonts.adamina(
                          fontSize: ModifiedTextFontSize.medium,
                          color: (context.read<ThemeCubit>().state.brightness ==
                                  Brightness.light)
                              ? Colors.blueGrey
                              : Colors.lightGreen)),
                ])),
                verticalIndent(),
                if (actor.birthDay != null)
                  ModifiedEnglishText(
                      text: 'Date of birth : ${actor.birthDay}'),
                verticalIndent(),
                if (actor.deathDay != null)
                  ModifiedEnglishText(
                      text: 'Date of death : ${actor.deathDay}'),
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
      ),
    );
  }
}
