import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(height: 500,width: MediaQuery.of(context).size.width,
        child: MasonryGridView.count(itemCount: 10,
        crossAxisCount: 2,
        mainAxisSpacing: 3,
        crossAxisSpacing: 4,
        itemBuilder: (context, index) {
          return Container(
height: 50,width: 50,color: Colors.red,
          );
        },
        ),
      )
    );
  }
}
