import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:psa/models/settings.dart';
import 'package:psa/models/user_details.dart';
import 'package:psa/screens/Home/Basketball/bbissued.dart';
import 'package:psa/screens/Home/Basketball/bbrequested.dart';
import 'package:psa/screens/Home/Basketball/bbreturn.dart';
import 'package:psa/screens/Home/Basketball/size_no.dart';
import 'package:psa/screens/Home/table_tennis/pop_up_widget.dart';
import 'package:psa/widget/IssueEquimentButton.dart';
import 'package:psa/widget/commonSportText.dart';
import 'package:psa/widget/middlewidget.dart';
import 'package:psa/widget/topcurve.dart';

class BasketBallScreen extends StatefulWidget {
  const BasketBallScreen({Key? key}) : super(key: key);

  @override
  _BasketBallScreenState createState() => _BasketBallScreenState();
}

class _BasketBallScreenState extends State<BasketBallScreen> {
  bool _isFirstView = false;
  dynamic _noOfBallSix, _size, _sizeSix, _sizeSeven;
  int _isRequested = 0;

  final _totalBallSix = int.parse(Equipment.basketballsix.toString());
  final _totalBallSeven = int.parse(Equipment.basketballseven.toString());

  Future getStatus() async {
    var v = await FirebaseFirestore.instance
        .collection('BBEquipment')
        .doc(UserDetails.uid)
        .get();
    if (v.exists) {
      _isRequested = v.get('isRequested');
      _noOfBallSix = v.get('noOfBall');
      _size = v.get('size');
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

  void bbSixLogic(String six, String seven) {
    List? l;
    l?.clear();
    l?.add(six);
    l?.add(seven);
    _isFirstView
        ? Navigator.of(context).pushNamed(
            SixNo.routeName,
            arguments: [six, seven],
          )
        : _isRequested == 1
            ? showDialog(
                context: context,
                builder: (context) {
                  return PopUpRequest(
                      onTap: () {
                        FirebaseFirestore.instance
                            .collection('BBEquipment')
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
                      return BBSixReturn(
                        onTap: () async {
                          await FirebaseFirestore.instance
                              .collection('BBEquipment')
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
                        size: _size,
                        noOfBall: _noOfBallSix,
                      );
                    })
                : Navigator.of(context).pushNamed(
                    SixNo.routeName,
                    arguments: [six, seven],
                  );
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
          stream:
              FirebaseFirestore.instance.collection('BBEquipment').snapshots(),
          builder: (ctx, userSnapshot) {
            if (userSnapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final usersnap = userSnapshot.data!.docs;
            _sizeSix = 0;
            _sizeSeven = 0;
            for (int i = 0; i < usersnap.length; i++) {
              if (usersnap[i]['size'] == "6") {
                if (usersnap[i]['isRequested'] == 2) {
                  _sizeSix += int.parse(usersnap[i]['noOfBall']);
                }
              }
              if (usersnap[i]['size'] == "7") {
                if (usersnap[i]['isRequested'] == 2) {
                  _sizeSeven += int.parse(usersnap[i]['noOfBall']);
                }
              }
            }
            return SizedBox(
              width: width,
              height: height,
              child: SingleChildScrollView(
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.start
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
                            name: 'BasketBall',
                            image: 'assets/basketball.jpg',
                          ),
                          TextCommon(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return const Requested();
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
                                  return const BBIssued();
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
                                  return const BBReturn();
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
                              padding:
                                  const EdgeInsets.only(left: 0.0, right: 12),
                              child: SizedBox(
                                height: height * 0.4,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 18.0, vertical: 25),
                                      child: RowInfo(
                                        ball: (_totalBallSeven - _sizeSix)
                                            .toString(),
                                        ball_size: 'Ball Left of Size six',
                                        size: 70,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 18.0, vertical: 25),
                                      child: RowInfo(
                                        ball: (_totalBallSeven - _sizeSeven)
                                            .toString(),
                                        ball_size: 'Ball Left of Size seven',
                                        size: 70,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          IssueEquimentWidget(
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
                                bbSixLogic(
                                    (_totalBallSix - _sizeSix).toString(),
                                    (_totalBallSeven - _sizeSeven).toString());
                              })
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}

class BBSixReturn extends StatelessWidget {
 final  String size;
 final VoidCallback onTap;
  final String noOfBall;
  const BBSixReturn({
    Key? key,
    required this.noOfBall,
    required this.onTap,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      backgroundColor: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 1.0, vertical: 10),
        child: Container(
          height: 220,
          width: 200,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 35, right: 10, left: 40),
                child: Row(
                  children: [
                    Text(
                      'Returning $noOfBall ball \n\t\t\t\t\t\tof size $size',
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
                padding: const EdgeInsets.only(top: 20,right: 25, left: 10),
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
                      // const Icon(Icons.cancel, size: 40, color: Colors.white),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
