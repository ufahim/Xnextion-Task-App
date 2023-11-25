import 'package:hive/hive.dart';
part 'favourite_model.g.dart';
@HiveType(typeId: 0)
class FavouriteModel extends HiveObject {
  @HiveField(0)
 late String title;
  @HiveField(1)
 late String imageurl;
   FavouriteModel(this.title,this.imageurl, );
   
}