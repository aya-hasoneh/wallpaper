import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:wallpaper_app/constant/api.dart';

class DetailsProvide extends ChangeNotifier{
bool isFavorite = false;

isFavoriteWallPaper(){
  isFavorite  = true;
  notifyListeners();
}

Future downloadImage() async {
  final response = await http.get(Uri.parse(API.apiUrlWallpaper()),headers: {'Authorization': API.apiKey},);
  print('DownloadImage__Body ${response.body}');
  print('DownloadImage__StatusCode ${response.statusCode}');
  if (response.statusCode == 200) {
    final appDir = await getApplicationDocumentsDirectory();
    final fileName = API.apiUrlWallpaper().split('/').last;
    final filePath = '${appDir.path}/$fileName';

    final file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    print('Image downloaded and saved to: $filePath');
  } else {
    throw Exception('Failed to download image: ${response.statusCode}');
  }
}

//  Future downloadImage() async {
//    final file = File('/path/to/save/image.jpg');
//
//    final response = await http.get(Uri.parse(API.apiDownload),headers: {'Authorization': API.apiKey});
//   print('Download Image Body ${response.body}');
//   if(response.statusCode == 200){
//     await file.writeAsBytes(response.bodyBytes);
//     print('Image downloaded successfully!');
//   }else{
//     print('field download');
//   }
//
// }

}