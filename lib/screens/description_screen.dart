import 'package:flutter/material.dart';
import 'package:the_movies/utils/credentials.dart';
import 'package:the_movies/utils/modified_text.dart';
import 'package:tmdb_api/tmdb_api.dart';

class Description extends StatelessWidget {
  final String name, launchOn, description, bannerPath, posterPath;
  final int movieId;

  const Description({
    Key? key,
    required this.name,
    required this.launchOn,
    required this.description,
    required this.bannerPath,
    required this.posterPath,
    required this.movieId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TMDB tmdb = TMDB(ApiKeys(apiKey, readToken));
    Future<List> actorsListFuture =
        tmdb.v3.movies.getCredits(movieId).then((value) => value['cast']);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                Positioned(
                  child: SizedBox(
                    height: 350,
                    width: MediaQuery.of(context).size.width,
                    child: Image.network(baseUrl + bannerPath),
                  ),
                ),
                Positioned(
                    left: 10,
                    bottom: 0,
                    child: SizedBox(
                      height: 150,
                      child: Image.network(baseUrl + posterPath),
                    )),
                Positioned(
                  child: SizedBox(
                    width: 250,
                    child: ModifiedText(
                      text: 'Title: ' + name,
                      size: 18,
                    ),
                  ),
                  bottom: 25,
                  right: 10,
                ),
                Positioned(
                  child: SizedBox(
                    width: 250,
                    child: ModifiedText(
                      text: 'Starts on: ' + launchOn,
                      size: 18,
                    ),
                  ),
                  bottom: 6,
                  right: 10,
                ),
              ],
            ),
            const ModifiedText(
              text: 'Overview',
              size: 24,
              color: Colors.cyan,
            ),
            ModifiedText(text: description),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 200,
              width: MediaQuery.of(context).size.width,
              child: FutureBuilder<List>(
                  future: actorsListFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState != ConnectionState.done) {
                      return const Center(child:  CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      // return: show error widget
                    }
                    List actors = snapshot.data ?? [];
                    return ListView.builder(
                        // scrollDirection: Axis.horizontal,
                        itemCount: actors.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(
                                    baseUrl + actors[index]['profile_path']),
                              ),
                              trailing: Icon(actors[index]['gender'] == 2
                                  ? Icons.male
                                  : Icons.female),
                              title: Text(actors[index]['name']),
                              onTap: () {},
                            ),
                          );
                        });
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
