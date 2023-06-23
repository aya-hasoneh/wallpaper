import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_app/controllers/details_provider.dart';
import 'package:wallpaper_app/controllers/favorite_provider.dart';

import 'package:wallpaper_app/controllers/wallpaper_provider.dart';
import 'package:wallpaper_app/utls/favorite_database.dart';
import 'package:wallpaper_app/view/wallpaper_page.dart';

void main() {

  runApp(MultiProvider(providers: [
    Provider<FavoriteDatabase>(
      create: (_) => FavoriteDatabase.instance,
      dispose: (_, db) => db.closeDB(),
    ),
    ChangeNotifierProvider(create: (_) => WallpaperProvider()),
    ChangeNotifierProvider(create: (_) => DetailsProvide()),
    ChangeNotifierProvider(create: (_) => FavoriteProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// ScreenUtilInt --> I use it for make the app responsive
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(debugShowCheckedModeBanner: false,
          home: WallpaperHome(),
        );
      },
    );
  }
}
