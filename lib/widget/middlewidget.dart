import 'package:flutter/material.dart';

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
            style: const TextStyle(color: Colors.white,
                fontSize: 15,
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
                style: const TextStyle(color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
