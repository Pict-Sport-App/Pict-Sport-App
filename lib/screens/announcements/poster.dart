import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class photo extends StatefulWidget {
  late String image;
  photo({required this.image});

  @override
  _photoState createState() => _photoState();
}

class _photoState extends State<photo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PhotoView(imageProvider: NetworkImage(widget.image),),
    );
  }
}