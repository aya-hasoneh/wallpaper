import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_app/controllers/wallpaper_provider.dart';
import 'package:wallpaper_app/model/wallpaper_model.dart';
import 'package:wallpaper_app/shared_widget/button_widget.dart';

import 'package:wallpaper_app/shared_widget/text_form_feild.dart';
import 'package:wallpaper_app/view/details_page.dart';
import 'package:wallpaper_app/view/favorite_page.dart';

class WallpaperHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final wallpaperProvider = Provider.of<WallpaperProvider>(context);


    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        floatingActionButton: SharedButton(
          icon: Icon(
            Icons.favorite,
            size: 25.h,
            color: Colors.white,
          ),
          colors: Colors.red,
          onPressed: () async{


            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  FavoritePage()),
            );
          },
        ),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            'Wallpapers',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: SingleChildScrollView(
          child: Form(
            child: Padding(
              padding: EdgeInsets.only(left: 5.w, right: 5.w),
              child: Column(children: [
                const TextFormFeildWidget(),
                FutureBuilder<WallpaperModel>(
                  future: wallpaperProvider.fetchWallpapers(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      print('Is there an error? ${snapshot.hasError}');
                      print('This is the error: ${snapshot.error}');
                      return const Center(
                          child: Text('Failed to fetch wallpapers'));
                    } else {
                      if (snapshot.hasData) {
                        return Container(
                          height: 550.h,
                          width: MediaQuery.of(context).size.width,
                          child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ),
                            itemCount: snapshot.data!.photos!.length,
                            itemBuilder: (BuildContext context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => DetailScreen(
                                          photo: snapshot.data!.photos![index]),
                                    ),
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      image: NetworkImage(snapshot
                                          .data!.photos![index].src!.medium!),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      } else {
                        return const Center(child: Text('No wallpapers found'));
                      }
                    }
                  },
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
