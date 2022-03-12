import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:psa/models/settings.dart';
import 'package:psa/models/user_details.dart';
import 'package:psa/screens/Home/Football/issueEuiment.dart';
import 'package:psa/screens/Home/Football/palyingScreen.dart';
import 'package:psa/screens/Home/Football/requestedScreen.dart';
import 'package:psa/screens/Home/Football/returnedScreen.dart';
import 'package:psa/screens/Home/VolleyBall/Volleyball.dart';
import 'package:psa/screens/Home/table_tennis/pop_up_widget.dart';
import 'package:psa/screens/otherUserDetails/helper/custom_clipper.dart';

class FootBallScreen extends StatefulWidget {
  const FootBallScreen({Key? key}) : super(key: key);

  @override
  _FootBallScreenState createState() => _FootBallScreenState();
}

class _FootBallScreenState extends State<FootBallScreen> {

  bool _isFirstView = false;
  dynamic _noOfBall,_n;
  int _isRequested = 0;

  final _totalBall = int.parse(Equipment.football.toString());

  void logicFF() {

    _isFirstView
        ? Navigator.of(context).pushNamed(
      FootBallIssue.routeName,
      arguments: _totalBall - _n,
    )
        : _isRequested == 1
        ? showDialog(
        context: context,
        builder: (context) {
          return PopUpRequest(
              onTap: () {
                FirebaseFirestore.instance
                    .collection('FFEquipment')
                    .doc(UserDetails.uid)
                    .update({
                  'isRequested': 3,
                });
                setState(() {
                  _isFirstView = true;
                });
                Navigator.pop(context);
              },
              text: 'Want to cancel the request');
          //---------
        })
        : _isRequested == 2
        ? showDialog(
        context: context,
        builder: (context) {
          return VVReturn(
            onTap: () async {
              await FirebaseFirestore.instance
                  .collection('FFEquipment')
                  .doc(UserDetails.uid)
                  .update({
                'isRequested': 4,
                'isReturn': true,
                'timeOfReturn': Timestamp.now(),
              });
              setState(() {
                _isFirstView = true;
              });
              Navigator.pop(context);
            },
            noOfBall: _noOfBall,
          );
        })
        : Navigator.of(context).pushNamed(
      FootBallIssue.routeName,
      arguments: _totalBall - _n,
    );
  }

  Future getStatus() async {
    var v = await FirebaseFirestore.instance
        .collection('FFEquipment')
        .doc(UserDetails.uid)
        .get();
    if (v.exists) {
      _isRequested = v.get('isRequested');
      _noOfBall = v.get('noOfBall');
      if (_isRequested == 3 || _isRequested == 5) {
        setState(() {
          _isFirstView = true;
        });
      } else {
        setState(() {
          _isFirstView = false;
        });
      }
    } else {
      setState(() {
        _isFirstView = true;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getStatus();
  }


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder<QuerySnapshot>(
          stream:
          FirebaseFirestore.instance.collection('FFEquipment')
              .snapshots(),
          builder: (ctx, userSnapshot){
            if (userSnapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            final usersnap = userSnapshot.data!.docs;
            _n = 0;
            for (int i = 0; i < usersnap.length; i++) {
              if (usersnap[i]['isRequested'] == 2) {
                _n += int.parse(usersnap[i]['noOfBall']);
              }
            }

            return Column(
              children: [
                const FootBallUpper(),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                  child: Container(
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        //SizedBox(width: weight*0.005,),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Ball Left ',
                            style: TextStyle(
                              fontSize: 17,
                              color: Colors.black,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: width * 0.004,
                        ),
                        const FaIcon(
                          FontAwesomeIcons.arrowAltCircleRight,
                          color: Colors.black,
                          size: 20,
                        ),
                        const Spacer(),
                        Text(
                          (_totalBall - _n).toString(),
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: width * 0.4,
                  //color: Colors.red,
                  child: FlatButton(
                    onPressed: () {
                      logicFF();
                    },
                    child: Center(
                      child: _isFirstView
                          ? const Center(
                        child: Text(
                          'Issue Ball',
                          style: TextStyle(
                            color: Colors.redAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                      )
                          : _isRequested == 1
                          ? const Center(
                        child: Text(
                          'Cancel Request',
                          style: TextStyle(
                            color: Colors.redAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                      )
                          : _isRequested == 2
                          ? const Center(
                        child: Text(
                          'Return Ball',
                          style: TextStyle(
                            color: Colors.redAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                      )
                          : _isRequested == 4
                          ? const Center(
                        child: Text(
                          'Issue Ball',
                          style: TextStyle(
                            color: Colors.redAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                      )
                          : Container(),
                    ),
                  ),
                ),
              ],
            );
          }
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
