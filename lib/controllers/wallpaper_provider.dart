import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:wallpaper_app/constant/api.dart';
import 'package:wallpaper_app/model/wallpaper_model.dart';
import 'package:http/http.dart' as http;

class WallpaperProvider with ChangeNotifier {
  WallpaperModel? wallpapers;
  var formKey = GlobalKey<FormState>();
  TextEditingController searchController = TextEditingController();

  Future<WallpaperModel> fetchWallpapers() async {
    String apiUrl;

    if (searchController.text != '') {
      apiUrl = API.apiSearch(searchController.text);
    } else {
      apiUrl = API.apiUrlWallpaper();
    }
    final response = await http.get(Uri.parse(apiUrl), headers: {
      'Authorization': API.apiKey,
    });
    print('Wallpaper__body ${response.body}');
    print('Wallpaper__stausCode ${response.statusCode}');
    if (response.statusCode == 200) {
      wallpapers = WallpaperModel.fromJson(json.decode(response.body));

      return wallpapers!;
    } else {
      throw Exception('No Found Wallpaper');
    }
  }
}
