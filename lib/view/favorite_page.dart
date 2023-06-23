import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_app/controllers/favorite_provider.dart';
import 'package:wallpaper_app/model/wallpaper_model.dart';

class FavoritePage extends StatelessWidget {
   FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final favoriteProvider = Provider.of<FavoriteProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        elevation: 0,
        title: const Text('Favorite'),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: favoriteProvider.favorites.length,
        itemBuilder: (context, index) {
          final favorite = favoriteProvider.favorites[index];
          return ListTile(
            title: Image.network(favorite.imageUrl! ),
            // You can display the favorite image here or customize the UI as desired
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: () {
          favoriteProvider.loadFavorites(); // Reload favorites
        },
        child: Icon(Icons.refresh),
      ),
    );
  }
}
