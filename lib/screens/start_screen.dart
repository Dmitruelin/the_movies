import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movies/bloc/get_films/get_now_playing_films_cubit.dart';
import 'package:the_movies/bloc/get_films/get_popular_films_cubit.dart';
import 'package:the_movies/utils/constants.dart';
import 'package:the_movies/widgets/films_list.dart';
import 'package:the_movies/widgets/popular_films.dart';
import 'package:the_movies/widgets/search_movie.dart';
import 'package:the_movies/widgets/theme_switch.dart';

import '../generated/l10n.dart';
import '../theme/theme_cubit.dart';
import '../utils/modified_text.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  int _selectedIndex = 0;
  bool isEnglish = true;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(baseUrlForBackground),
              fit: BoxFit.fitWidth,
              alignment: Alignment.topCenter,
              scale: 0.25,
            ),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              decoration: BoxDecoration(color: Colors.white.withOpacity(0.0)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomScrollView(
                    physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    slivers: <Widget>[
                      SliverAppBar(
                        leading: IconButton(
                            onPressed: localeMenu,
                            icon: const Icon(Icons.language)),
                        backgroundColor: Colors.transparent,
                        stretch: true,
                        centerTitle: true,
                        actions: [
                          IconButton(
                              onPressed: () {
                                showSearch(
                                  context: context,
                                  delegate: MovieSearch(),
                                );
                              },
                              icon: const Icon(Icons.search))
                        ],
                        flexibleSpace: FlexibleSpaceBar(
                          stretchModes: const <StretchMode>[
                            StretchMode.fadeTitle,
                            StretchMode.blurBackground,
                            StretchMode.zoomBackground,
                          ],
                          title: Text(S.of(context).searchTitle),
                          centerTitle: true,
                        ),
                      ),
                      SliverList(
                        delegate: SliverChildListDelegate(<Widget>[
                          // verticalIndent(),
                          // const FilmsListFromDatabase(),
                          verticalIndent(),
                          ModifiedText.withShadows(
                            text: S.of(context).nowPlaying,
                            size: ModifiedTextFontSize.large,
                            color: Colors.white,
                          ),
                          verticalIndent(),
                          const FilmsList(),
                          verticalIndent(),
                          ModifiedText.withShadows(
                            text: S.of(context).popularFilms,
                            size: ModifiedTextFontSize.large,
                            color:
                                (context.read<ThemeCubit>().state.brightness ==
                                        Brightness.light)
                                    ? Colors.amberAccent
                                    : Colors.white,
                          ),
                          verticalIndent(),
                          const PopularFilms(),
                          verticalIndent(),
                        ]),
                      ),
                    ]),
              ),
            ),
          )),
      bottomNavigationBar: AnimatedCrossFade(
        duration: const Duration(milliseconds: 500),
        secondChild: Row(
          children: const [ThemeSwitch()],
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
        ),
        firstChild: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: const Icon(Icons.home),
              label: S.of(context).home,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.color_lens),
              label: S.of(context).themeSwitch,
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.amber,
          onTap: _onItemTapped,
        ),
        crossFadeState: _selectedIndex == 0
            ? CrossFadeState.showFirst
            : CrossFadeState.showSecond,
      ),
    );
  }

  void localeMenu() {
    if (isEnglish) {
      setState(() {
        S.load(const Locale("ru", "RU"));
        isEnglish = false;
        context.read<GetFilmsCubit>().getFilms('ru-RU');
        context.read<GetPopularFilms>().getPopularFilms('ru-RU');
      });
    } else {
      setState(() {
        S.load(const Locale("en", "US"));
        isEnglish = true;
        context.read<GetFilmsCubit>().getFilms('en-US');
        context.read<GetPopularFilms>().getPopularFilms('en-US');
      });
    }
  }
}
