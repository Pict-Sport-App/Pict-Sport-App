import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:psa/models/settings.dart';
import 'package:psa/models/user_details.dart';
import 'package:psa/screens/Home/Badminton/issue.dart';
import 'package:psa/screens/Home/Badminton/playing.dart';
import 'package:psa/screens/Home/Badminton/requested.dart';
import 'package:psa/screens/Home/Badminton/return.dart';
import 'package:psa/screens/Home/table_tennis/pop_up_widget.dart';
import 'package:psa/widget/IssueEquimentButton.dart';
import 'package:psa/widget/commonSportText.dart';
import 'package:psa/widget/middlewidget.dart';
import 'package:psa/widget/topcurve.dart';

class BadmintonScreen extends StatefulWidget {
  const BadmintonScreen({Key? key}) : super(key: key);

  @override
  _BadmintonScreenState createState() => _BadmintonScreenState();
}

class _BadmintonScreenState extends State<BadmintonScreen> {
  bool _isFirstView = false;
  dynamic _noOfRacket, _noOfCock;
  int _isRequested = 0;
  final _totalRacket = int.parse(Equipment.badmintonRacket.toString());
  final _totalCock=int.parse(Equipment.badmintonCock.toString());

  void logicBT() {
    _isFirstView
        ? Navigator.of(context).pushNamed(
      BadmintonIssue.routeName,
      arguments: [_totalRacket-_noOfRacket,_totalCock-_noOfCock],
    )
        : _isRequested == 1
        ? showDialog(
        context: context,
        builder: (context) {
          return PopUpRequest(
              onTap: () {
                FirebaseFirestore.instance
                    .collection('BTEquipment')
                    .doc(UserDetails.uid)
                    .update({
                  'isRequested': 3,
                });
                setState(() {
                  _isFirstView = true;
                });
                Navigator.pop(context);
              },
              text: 'Cancel the request');
          //---------
        })
        : _isRequested == 2
        ? showDialog(
        context: context,
        builder: (context) {
          return BTRe(noOfCock: _noOfCock.toString(),
              noOfRacket: _noOfRacket.toString(),
              onTap: ()async{
                await FirebaseFirestore.instance
                    .collection('BTEquipment')
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
              });
        })
        : Navigator.of(context).pushNamed(
      BadmintonIssue.routeName,
      arguments: [_totalRacket-_noOfRacket,_totalCock-_noOfCock],
    );
  }

  Future getStatus() async {
    var v = await FirebaseFirestore.instance
        .collection('BTEquipment')
        .doc(UserDetails.uid)
        .get();
    if (v.exists) {
      _isRequested = v.get('isRequested');
      _noOfRacket = v.get('noOfRacket');
      _noOfCock=v.get('noOfCock');
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
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('BTEquipment')
            .snapshots(),
        builder: (ctx, userSnapshot){
          if (userSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final usersnap = userSnapshot.data!.docs;
          _noOfRacket=0;_noOfCock=0;
          for (int i = 0; i < usersnap.length; i++) {
            if (usersnap[i]['isRequested'] == 2) {
              _noOfCock += int.parse(usersnap[i]['noOfCock']);
              _noOfRacket+=int.parse(usersnap[i]['noOfRacket']);
            }
          }
          return SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(
                  // color: Colors.lightGreen,
                  width: MediaQuery.of(context).size.width,
                  height: height * 0.4, //320,
                  child: Stack(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: CustomPaint(
                          size: Size(width, 340), //2
                          painter: LogoPainter(), //3
                        ),
                      ),
                      const Pop(),
                      const TopName(
                        name: 'Badminton',
                        tag: 'bd',
                        image: 'assets/badminton.jpg',
                      ),
                      TextCommon(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                                  return const BadmintonRequested();
                                }));
                          },
                          right: width / 1.89,
                          bottom: 80,
                          name: 'Requested',
                          count: '2'),
                      TextCommon(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                                  return const BadmintonPlaying();
                                }));
                          },
                          right: width / 3.22,
                          bottom: 80,
                          name: 'Issued',
                          count: '45'),
                      TextCommon(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                                  return const BadmintonReturn();
                                }));
                          },
                          right: width / 40,
                          bottom: 80,
                          name: 'Returned',
                          count: '6'),
                    ],
                  ),
                ),
                Container(
                  height: height * 0.61236,
                  // color: Colors.blue,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xffbd274f2),
                          Color(0xff9507c4),
                        ]),
                  ),
                  child: Stack(
                    children: [
                      const Constan(),
                      Positioned(
                        top: 12,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 0.0),
                          child: SizedBox(
                            height: height * 0.4,
                            child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceAround,
                              children:  <Widget>[
                                // Text(" 'Ball Left")
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 18.0, vertical: 8),
                                  child: RowInfo(
                                    ball_size: 'Racket Left',
                                    ball: (_totalRacket - _noOfRacket).toString(),
                                    size: 80,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 18.0, vertical: 8),
                                  child: RowInfo(
                                    ball_size: 'Shuttle Cock Left',
                                    ball: (_totalCock - _noOfCock).toString(),
                                    size: 80,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 18.0),
                        child: IssueEquimentWidget(
                            name: _isFirstView
                                ? const Button(name: 'Issue')
                                : _isRequested == 1
                                ? const Button(name: 'Cancel Request')
                                : _isRequested == 2
                                ? const Button(name: 'Return Ball')
                                : _isRequested == 4
                                ? const Button(name: 'Issue')
                                : Container(),
                            onTap: () {
                              logicBT();
                            }),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class BTRe extends StatelessWidget {
  final String noOfRacket,noOfCock;
  final VoidCallback onTap;
  const BTRe({Key? key,
    required this.noOfCock,
    required this.noOfRacket,
    required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      backgroundColor: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 1.0, vertical: 10),
        child: Container(
          height: 250,
          width: 200,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Expanded(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 35, right: 10, left: 40),
                  child: Row(
                    children: [
                      const Text(
                        'Returning ',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        "$noOfRacket Racket",
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 35, right: 10, left: 40),
                  child: Row(
                    children: [
                      const Text(
                        'Returning ',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        "$noOfCock Cock",
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 45, right: 25, left: 10),
                  child: SizedBox(
                    height: 0.80,
                    child: Container(
                      width: MediaQuery.of(context).size.width * .9,
                      margin: const EdgeInsetsDirectional.only(
                          start: 1.0, end: 2.0),
                      height: 2.0,
                      color: Colors.black,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25, right: 5, left: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: onTap,
                        child: const FaIcon(
                          FontAwesomeIcons.checkCircle,
                          color: Colors.lightGreen,
                          size: 40,
                        ),
                      ),
                      GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const FaIcon(
                            FontAwesomeIcons.timesCircle,
                            color: Colors.redAccent,
                            size: 40,
                          )
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
