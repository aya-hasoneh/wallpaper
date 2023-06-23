import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:wallpaper_app/model/wallpaper_model.dart';

class DetailsProvide extends ChangeNotifier {

  isFavorite({required Photos photos}) {
    photos.src!.isFavorite = true;
    notifyListeners();
  }

  isDownloadImage({required Photos photos}) {
    photos.src!.isDownload = true;
    notifyListeners();
  }

  Future downloadImage({required Photos photos}) async {
    print('image url ${photos.src!.large}');
    GallerySaver.saveImage(photos.src!.large!).then((success) {
      print('download image');
    });
  }
}
