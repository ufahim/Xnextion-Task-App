import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xnextion_task_app/Screens/DetailScren.dart';
import 'package:xnextion_task_app/models/movie_model.dart';
import 'package:xnextion_task_app/view_models/movie_detail.dart';

class HomePage extends StatelessWidget {
  final MovieDetailsViewModel viewModel = Get.put(MovieDetailsViewModel());

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: viewModel.getNewReleases(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            MovieModel movieModel = snapshot.data as MovieModel;
            return ListView.builder(
              itemCount: movieModel.results!.length,
              itemBuilder: (context, index) {
                var movie = movieModel.results![index];
                return InkWell(
                  onTap: () {
                    var movie = movieModel.results![index];

                    Get.to(DetailScreen(movieModel: movie));
                  },
                  child: ListTile(
                    subtitle: Text(
                      movie.overview?.toString() ?? 'No Title',
                      maxLines: 2,
                      style: const TextStyle(
                        fontSize: 10,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    title: Text(movie.title?.toString() ?? 'No Title'),
                    trailing: Text(
                        movie.releaseDate?.toString() ?? 'No Release Date'),
                    leading: movie.posterPath != null
                        ? Image.network(
                            'https://image.tmdb.org/t/p/w200${movie.posterPath}',
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          )
                        : Container(),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
