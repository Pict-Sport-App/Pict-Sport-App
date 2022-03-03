import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class Photo extends StatefulWidget {
  late String image;
  Photo({Key? key, required this.image}) : super(key: key);

  @override
  _PhotoState createState() => _PhotoState();
}

class _PhotoState extends State<Photo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PhotoView(imageProvider: NetworkImage(widget.image),),
    );
  }
}