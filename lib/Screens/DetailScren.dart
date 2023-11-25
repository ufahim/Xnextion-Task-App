import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:xnextion_task_app/Screens/favourite_screen.dart';
import 'package:xnextion_task_app/hive/favourite_model.dart';
import 'package:xnextion_task_app/view_models/movie_detail.dart';

class DetailScreen extends StatelessWidget {
  DetailScreen({Key? key, required this.movieModel}) : super(key: key);
  final movieModel;
  MovieDetailsViewModel model = MovieDetailsViewModel();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: Column(
            children: [
              Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        child: movieModel.posterPath != null
                            ? Image.network(
                                'https://image.tmdb.org/t/p/w200${movieModel.posterPath}',
                                width: double.infinity,
                                height: 300.h,
                                fit: BoxFit.cover,
                              )
                            : Container(),
                      ),
                      ListTile(
                        subtitle: Text(
                          movieModel.overview?.toString() ?? 'No Title',
                          maxLines: 5,
                          style: TextStyle(
                            fontSize: 10.sp,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        title: Text(movieModel.title?.toString() ?? 'No Title'),
                      )
                    ],
                  ),
                  Positioned(
                    top: 0,
                    right: 8,
                    child: IconButton(
                      onPressed: () {
                        model.addToFavourite(
                          movieModel.title!.toString(),
                          movieModel.posterPath.toString(),
                        );
                      },
                      icon: const Icon(
                        Icons.favorite_outline,
                        color: Colors.red,
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ))
                ],
              ),
              ListTile(
                onTap: () {
                  Get.to(const Favourite());
                },
                title: const Text(
                  'Favourite Movies',
                ),
                trailing: const Icon(Icons.navigate_next),
              )
            ],
          ),
        ),
      ),
    );
  }
}
