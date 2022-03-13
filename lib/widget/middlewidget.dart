import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MiddleWidget extends StatelessWidget {
  final String number,text1;
  const MiddleWidget({Key? key,
  required this.number,
  required this.text1}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children:  <Widget>[
          Text(
            number,
            style: const TextStyle(color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            width: 100,
          ),
          Padding(
            padding:
            const EdgeInsets.only(right: 48.0),
            child: SizedBox(
              width: 200,
              child: Text(
                text1,
                style: const TextStyle(color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w800),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class RowInfo extends StatelessWidget {
  RowInfo({required this.ball, required this.ball_size,required this.size});
  String? ball;
  String? ball_size;
  double size;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12.0),
      child: Container(
        // width: double.infinity,
        height:size==null? 65 : size,

        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(20),
        ),
        width: MediaQuery.of(context).size.width*0.9,
        child: Row(
          mainAxisAlignment:
          MainAxisAlignment.spaceEvenly,
          children: <Widget>[
             Padding(
               padding: const EdgeInsets.only(left: 8.0),
               child: Text(
                '$ball_size ',
                style: const TextStyle(
                  fontSize: 17,
                  color: Colors.black,
                  fontWeight: FontWeight.w900,
                ),
            ),
             ),
            const FaIcon(
              FontAwesomeIcons
                  .arrowAltCircleRight,
              color: Colors.black,
              size: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18.0),
              child: Text(
                '${ball}  ',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
