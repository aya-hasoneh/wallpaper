import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class DetailsProvide extends ChangeNotifier{
bool isFavorite = false;

isFavoriteWallPaper(){
  isFavorite  != isFavorite;
  notifyListeners();
}

Future downloadImage({ required int id , required String imageUrl}) async {
  final directory = await getApplicationSupportDirectory();
  final savePath = '${directory.path}/image.jpg';

  final taskId = await FlutterDownloader.enqueue(
    url: imageUrl,
    savedDir: savePath,
    showNotification: true,
    openFileFromNotification: true,
  );

  FlutterDownloader.registerCallback((id, status, progress) {
    if (status == DownloadTaskStatus.complete) {
      // Download completed
      print('Download completed');

    }
  });
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