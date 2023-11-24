import 'package:get/get.dart';
import 'package:xnextion_task_app/models/movie_model.dart';
import 'package:xnextion_task_app/services/api/api_manager.dart';
import 'package:xnextion_task_app/services/api/end_points.dart';
import 'package:xnextion_task_app/utils/constants.dart';

class MovieDetailsViewModel extends GetxController {
 Future<MovieModel> getNewReleases() async {
    var jsonData = await ApiManager.getData(
        EndPoints.upcoming, {"api_key": Constants.abiKey});

    MovieModel movieModel = MovieModel.fromJson(jsonData);

    return movieModel;
  }


}
