import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:the_movies/bloc/actor_info/actor_info_cubit.dart';
import 'package:the_movies/main.dart';
import 'package:the_movies/models/actor.dart';
import 'package:the_movies/theme/theme_cubit.dart';
import 'package:the_movies/utils/constants.dart';
import 'package:the_movies/utils/data_service.dart';
import 'package:the_movies/utils/modified_text.dart';
import 'package:the_movies/utils/photo_hero.dart';

class ActorDetailsScreen extends StatelessWidget {
  final int personId;
  final String posterPath;

  const ActorDetailsScreen(
      {Key? key, required this.personId, required this.posterPath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
          centerTitle: true,
        ),
        body: Column(children: [
          SizedBox(
            height: 220,
            child: PhotoHero(
              onTap: () {},
              width: MediaQuery.of(context).size.width,
              photo: baseUrlForImages + posterPath,
            ),
          ),
          BlocProvider<ActorInfoCubit>(
            create: (context) => ActorInfoCubit(getIt.get<DataService>())
              ..getActorPersonalInfo(personId),
            child: BlocBuilder<ActorInfoCubit, ActorInfoState>(
                builder: (context, state) {
              if (state is ActorInfoLoadingState) {
                return const CircularProgressIndicator();
              }
              if (state is ActorInfoLoadedState) {
                final Actor actor = state.actor;
                return Flexible(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      Row(children: [
                        const ModifiedText.withShadows(
                          text: 'Name :  ',
                          size: 19,
                        ),
                        Text('${actor.name}',
                            style: GoogleFonts.adamina(
                                fontSize: ModifiedTextFontSize.medium,
                                fontWeight: FontWeight.bold,
                                color: (context
                                            .read<ThemeCubit>()
                                            .state
                                            .brightness ==
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
                                color: (context
                                            .read<ThemeCubit>()
                                            .state
                                            .brightness ==
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
                  ),
                );
              }
              if (state is ErrorState) {
                return const Icon(Icons.close);
              } else {
                return Container();
              }
            }),
          ),
        ]));
  }
}
