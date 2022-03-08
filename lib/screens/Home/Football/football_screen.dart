import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:psa/screens/Home/Football/issueEuiment.dart';
import 'package:psa/screens/Home/Football/palyingScreen.dart';
import 'package:psa/screens/Home/Football/requestedScreen.dart';
import 'package:psa/screens/Home/Football/returnedScreen.dart';
import 'package:psa/screens/otherUserDetails/helper/custom_clipper.dart';

class FootBallScreen extends StatefulWidget {
  const FootBallScreen({Key? key}) : super(key: key);

  @override
  _FootBallScreenState createState() => _FootBallScreenState();
}

class _FootBallScreenState extends State<FootBallScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const FootBallUpper(),
          RaisedButton(onPressed: (){
            Navigator.push(context,
                MaterialPageRoute(builder: (context){
                  return const FootBallIssue();
                }));
          },
            child: const Text('Issue'),)
        ],
      ),
    );
  }
}


class FootBallUpper extends StatefulWidget {
  const FootBallUpper({Key? key}) : super(key: key);

  @override
  _FootBallUpperState createState() => _FootBallUpperState();
}

class _FootBallUpperState extends State<FootBallUpper> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return  SizedBox(
      height: 390.0,
      child: Stack(
        children: <Widget>[
          ClipPath(
            clipper: MyCustomClipper(),
            child: Container(
              height: 350.0,
              width: double.infinity,
              child: Lottie.asset('assets/ff_loty.json'),
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
          return const RequestedFootball();
        }));
        break;
      case 1:
      // print("second button is pressed");
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return const PlayingFootBall();
        }));
        break;
      case 2:
      // print("second button is pressed");
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return const ReturnedFootball();
        }));
        break;
    }
  }
}
