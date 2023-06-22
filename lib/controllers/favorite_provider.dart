import 'package:flutter/cupertino.dart';
import 'package:wallpaper_app/model/favorite_model.dart';
import 'package:wallpaper_app/utls/favorite_database.dart';

class FavoriteProvider extends ChangeNotifier{
  List<FavoriteModel> favorites = [];

  Future loadFavorites() async {
    final favoriteList = await FavoriteDatabase.instance.readAllFavorite();
    favorites = favoriteList;
    notifyListeners();
  }
}