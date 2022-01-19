import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:the_movies/utils/credentials.dart';
import 'package:the_movies/utils/modified_text.dart';
import 'package:the_movies/widgets/films_list.dart';
import 'package:the_movies/widgets/popular_films.dart';
import 'package:tmdb_api/tmdb_api.dart';

class StartPage extends StatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  StartPage({Key? key}) : super(key: key);

  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  List nowPlayingMovies = [];
  List popularMovies = [];

  TextEditingController searchController = TextEditingController();

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    loadingMovies();
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  loadingMovies() async {
    TMDB tmdbCustomLogs = TMDB(ApiKeys(apiKey, readToken));
    Map nowPlayingMoviesResult = await tmdbCustomLogs.v3.movies.getNowPlaying();
    Map popularMoviesResult = await tmdbCustomLogs.v3.movies.getTopRated();
    setState(() {
      nowPlayingMovies = nowPlayingMoviesResult['results'];
      popularMovies = popularMoviesResult['results'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: TextField(
                    controller: searchController,
                    decoration: const InputDecoration(
                      suffixIcon: Icon(
                        Icons.search_sharp,
                        color: Colors.white,
                      ),
                      label: ModifiedText(
                        text: '     Search',
                        size: 18,
                        color: Colors.white,
                      ),
                      filled: true,
                      fillColor: Colors.grey,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        borderSide: BorderSide(
                          color: Colors.grey,
                          width: 4.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        borderSide: BorderSide(
                          color: Colors.blue,
                          width: 3.0,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                FilmsList(
                  nowPlayingMovies: nowPlayingMovies,
                ),
                const SizedBox(
                  height: 10,
                ),
                PopularFilms(
                  popularMovies: popularMovies,
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.view_stream_outlined), label: 'Cinema'),
          BottomNavigationBarItem(
            icon: Icon(Icons.tv),
            label: 'TV',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber,
        onTap: _onItemTapped,
      ),
    );
  }
}
