import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:xnextion_task_app/hive/favourite_model.dart';
import 'package:xnextion_task_app/view_models/movie_detail.dart';

class Favourite extends StatefulWidget {
  const Favourite({Key? key}) : super(key: key);

  @override
  State<Favourite> createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  final List<FavouriteModel> result = Hive.box<FavouriteModel>('favourite')
      .values
      .toList()
      .reversed
      .toList()
      .cast<FavouriteModel>();
MovieDetailsViewModel model=MovieDetailsViewModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Favourite',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
              onPressed: () {
                if (Hive.box<FavouriteModel>('favourite').isNotEmpty) {
                  Get.snackbar(
                    'All Delete',
                    'all deleted',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                    duration: const Duration(seconds: 3),
                    borderRadius: 10,
                    isDismissible: true,
                    forwardAnimationCurve: Curves.easeOutBack,
                    reverseAnimationCurve: Curves.easeInBack,
                    icon: const Icon(
                      Icons.delete_forever_outlined,
                      color: Colors.blue,
                    ),
                    shouldIconPulse: false,
                  );
                  Navigator.pop(context);
                  Hive.box<FavouriteModel>('favourite').clear();
                } else {}
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ))
        ],
      ),
      body: result.isEmpty
          ? Center(
              child: Text(
                'Empty!',
                style: Theme.of(context)
                    .textTheme
                    .caption
                    ?.copyWith(fontSize: 12.0.sp),
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(10.0),
              itemCount: result.length,
              separatorBuilder: (BuildContext context, int index) =>
                   SizedBox(height: 10.h),
              itemBuilder: (BuildContext context, int i) {
                return Material(
                  elevation: 2,
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: () {
                      model.delet(result[i]);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      child: ListTile(
                          title: Text(
                            'Title: ${result[i].title}',
                            style: const TextStyle(
                              color: Colors.blueGrey),
                          ),
                          leading: Image.network(
                            'https://image.tmdb.org/t/p/w200${result[i].imageurl.trim()}',
                            width: 50.w,
                            height: 50.h,
                            fit: BoxFit.cover,
                          ),
                          trailing: IconButton(
                            onPressed: () {
                              model.delet(result[i]);
                              Navigator.pop(context);
                              Get.snackbar(
                                'Delete',
                                'deleted',
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Colors.red,
                                colorText: Colors.white,
                                duration: const Duration(seconds: 3),
                                borderRadius: 10,
                                isDismissible: true,
                                forwardAnimationCurve: Curves.easeOutBack,
                                reverseAnimationCurve: Curves.easeInBack,
                                icon: const Icon(
                                  Icons.delete_forever_outlined,
                                  color: Colors.blue,
                                ),
                                shouldIconPulse: false,
                              );
                            },
                            icon: const Icon(
                              Icons.auto_delete_outlined,
                              color: Colors.red,
                            ),
                          )),
                    ),
                  ),
                );
              },
            ),
    );
  }

 
}
