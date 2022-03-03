import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TopBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const FaIcon(
              FontAwesomeIcons.arrowCircleLeft,
              color: Colors.white,
              size: 28,
            ),
          ),
          // IconButton(
          //   onPressed: () {},
          //   icon: const Icon(Icons.menu, color: Colors.white),
          // ),
        ],
      ),
    );
  }
}
