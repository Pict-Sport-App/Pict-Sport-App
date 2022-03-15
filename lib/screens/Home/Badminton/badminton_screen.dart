import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:psa/models/settings.dart';
import 'package:psa/models/user_details.dart';
import 'package:psa/screens/Home/Badminton/issue.dart';
import 'package:psa/screens/Home/Badminton/playing.dart';
import 'package:psa/screens/Home/Badminton/requested.dart';
import 'package:psa/screens/Home/Badminton/return.dart';
import 'package:psa/screens/Home/Football/palyingScreen.dart';
import 'package:psa/widget/IssueEquimentButton.dart';
import 'package:psa/widget/commonSportText.dart';
import 'package:psa/widget/topcurve.dart';

class BadmintonScreen extends StatefulWidget {
  const BadmintonScreen({Key? key}) : super(key: key);

  @override
  _BadmintonScreenState createState() => _BadmintonScreenState();
}

class _BadmintonScreenState extends State<BadmintonScreen> {
  bool _isFirstView = false;
  dynamic _noOfBall, _n;
  int _isRequested = 0;
  final _totalRacket = int.parse(Equipment.badmintonRacket.toString());
  final _totalCock=int.parse(Equipment.badmintonCock.toString());

  /*void logicVV() {
    _isFirstView
        ? Navigator.of(context).pushNamed(
      Issue.routeName,
      arguments: _totalBall - _n,
    )
        : _isRequested == 1
        ? showDialog(
        context: context,
        builder: (context) {
          return PopUpRequest(
              onTap: () {
                FirebaseFirestore.instance
                    .collection('VVEquipment')
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
          return VVReturn(
            onTap: () async {
              await FirebaseFirestore.instance
                  .collection('VVEquipment')
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
      Issue.routeName,
      arguments: _totalBall - _n,
    );
  }*/

  Future getStatus() async {
    var v = await FirebaseFirestore.instance
        .collection('BTEquipment')
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
    //getStatus();
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
          /*_n = 0;
          for (int i = 0; i < usersnap.length; i++) {
            if (usersnap[i]['isRequested'] == 2) {
              _n += int.parse(usersnap[i]['noOfBall']);
            }
          }*/
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
                              children: const <Widget>[
                                // Text(" 'Ball Left")
                                /*Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 18.0, vertical: 8),
                                  child: RowInfo(
                                    ball_size: 'Ball Left',
                                    ball: (_totalBall - _n).toString(),
                                    size: 80,
                                  ),
                                ),*/
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
                              Navigator.push(context,
                              MaterialPageRoute(builder: (context){
                                return BadmintonIssue();
                              }));
                             // logicVV();
                            }),
                      )
                    ],
                  ),
                ),
                // assets/bottom2.jpg
              ],
            ),
          );
        },
      ),
    );
  }
}
