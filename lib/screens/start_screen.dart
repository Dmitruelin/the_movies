import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:the_movies/utils/constants.dart';
import 'package:the_movies/widgets/films_list.dart';
import 'package:the_movies/widgets/popular_films.dart';
import 'package:the_movies/widgets/search_movie.dart';
import 'package:the_movies/widgets/theme_switch.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  int _selectedIndex = 0;

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
              child: CustomScrollView(
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  slivers: <Widget>[
                    SliverAppBar(
                      automaticallyImplyLeading: false,
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
                      flexibleSpace: const FlexibleSpaceBar(
                        stretchModes: <StretchMode>[
                          StretchMode.fadeTitle,
                          StretchMode.blurBackground,
                          StretchMode.zoomBackground,
                        ],
                        title: Text('Search bar'),
                        centerTitle: true,
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildListDelegate(<Widget>[
                        // verticalIndent(),
                        // const FilmsListFromDatabase(),
                        verticalIndent(),
                        const FilmsList(),
                        verticalIndent(),
                        const PopularFilms(),
                        verticalIndent(),
                      ]),
                    ),
                  ]),
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
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.color_lens),
              label: 'Theme switch',
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
}
