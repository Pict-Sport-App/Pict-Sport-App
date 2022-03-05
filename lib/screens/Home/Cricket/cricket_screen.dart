import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:psa/screens/Home/Cricket/playing.dart';
import 'package:psa/screens/Home/Cricket/requested.dart';
import 'package:psa/screens/Home/Cricket/returned.dart';
import 'package:psa/screens/otherUserDetails/helper/custom_clipper.dart';

class CricketScreen extends StatefulWidget {
  const CricketScreen({Key? key}) : super(key: key);

  @override
  _CricketScreenState createState() => _CricketScreenState();
}

class _CricketScreenState extends State<CricketScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: const [
          UpperCricket(),

        ],
      ),
    );
  }
}


class UpperCricket extends StatefulWidget {
  const UpperCricket({Key? key}) : super(key: key);

  @override
  _UpperCricketState createState() => _UpperCricketState();
}

class _UpperCricketState extends State<UpperCricket> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      height: 390.0,
      child: Stack(
        children: <Widget>[
          ClipPath(
            clipper: MyCustomClipper(),
            child: Container(
              height: 350.0,
              width: double.infinity,
              child: Lottie.asset('assets/cricket_lofy.json'),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(6, 3), // changes position of shadow
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: height * 0.06,
            right: width * 0.06,
            child: GestureDetector(
              onTap: () {},
              child: Container(
                height: 50,
                width: 50,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Center(
                  child: PopupMenuButton<int>(
                      color: Colors.indigo,
                      onSelected: (item) => onSelected(context, item),
                      itemBuilder: (context) => [
                        const PopupMenuItem<int>(
                          value: 0,
                          child: Text(
                            "Requested",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        const PopupMenuDivider(),
                        const PopupMenuItem<int>(
                          value: 1,
                          child: Text(
                            "Issued",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        const PopupMenuDivider(),
                        const PopupMenuItem<int>(
                          value: 2,
                          child: Text(
                            " Returned ",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ]),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  onSelected(BuildContext context, int item) {
    switch (item) {
      case 0:
      // print("First button is pressed");
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return const RequestedCricket();
        }));
        break;
      case 1:
      // print("second button is pressed");
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return const PlayingCricket();
        }));
        break;
      case 2:
      // print("second button is pressed");
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return const ReturnedCricket();
        }));
        break;
    }
  }
}
