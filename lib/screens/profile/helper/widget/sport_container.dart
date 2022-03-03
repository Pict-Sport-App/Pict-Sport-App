import 'package:flutter/material.dart';

class SportContainer extends StatefulWidget {

  SportContainer({Key? key, required this.discription,
    required this.headline,
    required this.fondSize}) : super(key: key);
  String? headline;
  String? discription;
  double fondSize;

  @override
  _SportContainerState createState() => _SportContainerState();
}

class _SportContainerState extends State<SportContainer> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '''
${widget.headline} ''',
          style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold
          ),
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                offset: Offset(0, 2),
                blurRadius: 3,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(19.0),
            child: SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  '${widget.discription}',
                  style:
                       TextStyle(fontSize: widget.fondSize,
                           fontFamily: "Poppins"),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

