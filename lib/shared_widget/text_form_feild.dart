import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_app/controllers/wallpaper_provider.dart';

class TextFormFeildWidget extends StatelessWidget {

  const TextFormFeildWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final wallpaperProvider = Provider.of<WallpaperProvider>(context);

    return  Padding(
      padding:  EdgeInsets.only(top: 20.h,bottom: 20.h),
      child: TextFormField(
        controller: wallpaperProvider.searchController,
        decoration: InputDecoration(
          labelText: 'Search...',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),

      ),
    );
  }
}
