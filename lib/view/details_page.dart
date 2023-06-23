import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_app/model/favorite_model.dart';
import 'package:wallpaper_app/model/wallpaper_model.dart';
import 'package:wallpaper_app/controllers/details_provider.dart';
import 'package:wallpaper_app/controllers/favorite_provider.dart';
import 'package:wallpaper_app/shared_widget/button_widget.dart';
import 'package:wallpaper_app/utls/favorite_database.dart';

class DetailScreen extends StatelessWidget {
  Photos? photo;
  DetailScreen({Key? key, required this.photo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final detailProvider = Provider.of<DetailsProvide>(context);
    final favoriteProvider = Provider.of<FavoriteProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        elevation: 0,
        title: const Text(
          'Wallpapers',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 20.w, right: 20.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.network(photo!.src!.large!),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SharedButton(
                    icon:  Icon(
                      photo!.src!.isDownload != true?
                      Icons.download:Icons.done,
                      color: Colors.white,
                    ),
                    colors: Colors.green,
                    onPressed: () {
                      print('save image button');
                      detailProvider.isDownloadImage(photos: photo!);

                      detailProvider.downloadImage(photos:photo!);
                    },
                  ),
                  SharedButton(
                    icon: Icon(
                      photo!.src!.isFavorite ==true
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: Colors.red,
                    ),
                    colors: Colors.white,
                    onPressed: () async {
                      print('click on button');
                      final imageUrl = photo!.photographerUrl;
                      print('image url is $imageUrl');
                      final favorite =
                          FavoriteModel(id: photo!.id, imageUrl: imageUrl);
                      await FavoriteDatabase.instance.create(favorite);

                      await favoriteProvider.loadFavorites();
                      detailProvider.isFavorite(photos: photo!);
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
