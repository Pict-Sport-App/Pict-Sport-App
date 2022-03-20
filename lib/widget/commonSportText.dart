import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Pop extends StatelessWidget {
  const Pop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 34,
      left: 6,
      child: Row(
        children: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const FaIcon(
              FontAwesomeIcons.arrowCircleLeft,
              color: Colors.white,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }
}


class TopName extends StatelessWidget {
  final String image,name,tag;
  const TopName({Key? key,required this.tag,required this.name,
  required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 90,
      left: 17,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: Row(
          children: <Widget>[
             SizedBox(
              width: MediaQuery.of(context).size.width*.03,
            ),
            CircleAvatar(
              radius: 44,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 43,
                backgroundColor: const Color(0xffb46eea),
                child: CircleAvatar(
                  radius: 42,
                  backgroundColor: Colors.white,
                  child: Hero(
                    tag: tag,
                    child: CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage(image),
                    ),
                  ),
                ),
              ),
            ),
             SizedBox(
              width: MediaQuery.of(context).size.width*.13,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children:  <Widget>[
                Text(
                  name,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 27),
                ),
                const Text(
                  "📍Pict,Pune",
                  style: TextStyle(
                      color: Colors.white60,
                      fontWeight: FontWeight.w500,
                      fontSize: 19),
                ),
              ],
            ),
          ],
        ),
        // ),
      ),
    );
  }
}


class TextCommon extends StatelessWidget {
  final double bottom,right;
  final VoidCallback onTap;
  final String count,name;
  const TextCommon({Key? key,
    required this.onTap,
    required this.right,
    required this.bottom,
    required this.name,
    required this.count
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: bottom,
      right: right,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.redAccent,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(
                  0,
                  0,
                ),
                blurRadius: 10.0,
                spreadRadius: 3.0,
              ), //BoxShadow
              BoxShadow(
                color: Colors.white,
                offset: Offset(0.0, 0.0),
                blurRadius: 0.0,
                spreadRadius: 0.0,
              ), //BoxShadow
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  count,
                  style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w900,
                      fontSize: 27),
                ),
                Text(
                 name,
                  style: const TextStyle(color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 15),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
