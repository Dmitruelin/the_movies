import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:the_movies/widgets/films_list.dart';
import 'package:the_movies/widgets/popular_films.dart';
import 'package:the_movies/widgets/search_movie.dart';
import 'package:the_movies/widgets/theme_switch.dart';

class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  TextEditingController searchController = TextEditingController();

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
              image: NetworkImage(
                  'https://funart.pro/uploads/posts/2020-04/1587215417_4-p-foni-dlya-prilozhenii-8.jpg'),
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
                        const SizedBox(
                          height: 10,
                        ),
                        const FilmsList(),
                        const SizedBox(
                          height: 10,
                        ),
                        const PopularFilms(),
                        const SizedBox(
                          height: 10,
                        ),
                        // const ThemeSwitch(),
                      ]),
                    ),
                  ]),
            ),
          )),
      bottomNavigationBar: AnimatedCrossFade(
        duration: const Duration(milliseconds: 700),
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
