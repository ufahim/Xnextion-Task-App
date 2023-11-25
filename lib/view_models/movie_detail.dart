import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:xnextion_task_app/models/movie_model.dart';
import 'package:xnextion_task_app/services/api/api_manager.dart';
import 'package:xnextion_task_app/services/api/end_points.dart';
import 'package:xnextion_task_app/utils/constants.dart';
import 'package:xnextion_task_app/hive/favourite_model.dart';

class MovieDetailsViewModel extends GetxController {
  Future<MovieModel> getNewReleases() async {
    var jsonData = await ApiManager.getData(
        EndPoints.upcoming, {"api_key": Constants.abiKey});

    MovieModel movieModel = MovieModel.fromJson(jsonData);

    return movieModel;
  }

  void delet(FavouriteModel favouriteModel) {
    favouriteModel.delete();
  }

  void addToFavourite(String title, String imageUrl) {
    if (title != null && imageUrl != null) {
      final historyBox = Hive.box<FavouriteModel>('favourite');
      bool alreadyExists = false;
      for (var i = 0; i < historyBox.length; i++) {
        FavouriteModel? item = historyBox.getAt(i);
        if (item!.title == title && item.imageurl == imageUrl) {
          alreadyExists = true;

          break;
        }
      }

      if (alreadyExists) {
        Get.snackbar(
          'Favourite',
          'Already in favourite',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.blue,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
          borderRadius: 10,
          isDismissible: true,
          forwardAnimationCurve: Curves.easeOutBack,
          reverseAnimationCurve: Curves.easeInBack,
          icon: const Icon(
            Icons.favorite_border_outlined,
            color: Colors.red,
          ),
          shouldIconPulse: false,
        );
      } else {
        final historyItem = FavouriteModel(
          title,
          imageUrl,
        );
        historyBox.add(historyItem);
        Get.snackbar(
          'Favourite',
          'added to favourite',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.blue,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
          borderRadius: 10,
          isDismissible: true,
          forwardAnimationCurve: Curves.easeOutBack,
          reverseAnimationCurve: Curves.easeInBack,
          icon: const Icon(
            Icons.favorite_border_outlined,
            color: Colors.red,
          ),
          shouldIconPulse: false,
        );
      }
    }
  }
}
