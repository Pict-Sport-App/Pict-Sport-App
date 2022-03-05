import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class Photo extends StatelessWidget {
  final String image;
  const Photo({Key? key,required this.image}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PhotoView(imageProvider: NetworkImage(image),),
    );
  }
}