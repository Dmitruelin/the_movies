import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movies/bloc/actors/actors_cubit.dart';
import 'package:the_movies/utils/credentials.dart';

class ActorsScreen extends StatelessWidget {
  const ActorsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Icon(Icons.people),
        centerTitle: true,
      ),
      body: BlocBuilder<ActorsCubit, List>(builder: (context, actors) {
        return GridView.builder(
          // scrollDirection: Axis.horizontal,
          itemCount: actors.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 6.0,
              child: Column(
                children: [
                  SizedBox(
                    height: 130,
                    child:
                        Image.network(baseUrl + actors[index]['profile_path']),
                  ),
                  ListTile(
                    trailing: Icon(actors[index]['gender'] == 2
                        ? Icons.male
                        : Icons.female),
                    title: Text(actors[index]['name']),
                    onTap: () {},
                  ),
                ],
              ),
            );
          },
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
        );
      }),
    );
  }
}
