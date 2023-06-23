import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_app/constant/colors.dart';
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

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.blackColor,
          ),
        ),
        elevation: 0,
        title: const Text(
          'Wallpapers',
          style: TextStyle(color: AppColors.blackColor,),
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
                    icon: Icon(
                      photo!.src!.isDownload != true
                          ? Icons.download
                          : Icons.done,
                      color: Colors.white,
                    ),
                    colors: Colors.green,
                    onPressed: () {
                      print('save image button');
                      /// check if click button or not
                      detailProvider.isDownloadImage(photos: photo!);

                      /// download image
                      detailProvider.downloadImage(photos: photo!);
                    },
                  ),
                  SharedButton(
                    icon: Icon(
                      photo!.src!.isFavorite == true
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: AppColors.redColor,
                    ),
                    colors: Colors.white,
                    onPressed: () async {
                      print('click on button');
                      /// check if click on favorite button
                      detailProvider.isFavorite(photos: photo!);
                      final favorite = Photos(
                          id: photo!.id!,
                          src: Src(
                            isDownload: false,
                            isFavorite: false,
                            large: photo!.src!.large,
                            medium: photo!.src!.medium,
                            small: photo!.src!.small,
                            tiny: photo!.src!.tiny,
                            landscape: photo!.src!.landscape,
                            large2x: photo!.src!.large2x,
                            portrait: photo!.src!.portrait,
                          ));
                      /// add favorite photo to favorite screen
                      await FavoriteDatabase.instance.create(photo: favorite);


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
