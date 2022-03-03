import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:psa/models/settings.dart';
import 'package:psa/models/user_details.dart';
import 'package:psa/screens/Home/Basketball/bbissued.dart';
import 'package:psa/screens/Home/Basketball/bbrequested.dart';
import 'package:psa/screens/Home/Basketball/bbreturn.dart';
import 'package:psa/screens/Home/Basketball/size_no.dart';
import 'package:psa/screens/Home/table_tennis/pop_up_widget.dart';
import 'package:psa/screens/otherUserDetails/helper/custom_clipper.dart';

class BasketBallScreen extends StatefulWidget {
  const BasketBallScreen({Key? key}) : super(key: key);

  @override
  _BasketBallScreenState createState() => _BasketBallScreenState();
}

class _BasketBallScreenState extends State<BasketBallScreen> {
  bool _isFirstView = false;
  var _noOfBallSix;
  var _size;
  int _isRequested = 0;

  final _totalBallSix = int.parse(Equipment.basketballsix.toString());
  final _totalBallSeven = int.parse(Equipment.basketballseven.toString());

  late var _sizeSix, _sizeSeven;

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
                      text: 'Want to cancel the request');
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
    double weight = MediaQuery.of(context).size.width;
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
              width: weight,
              height: height,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const StackContainer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            'Ball Info :-',
                            style: TextStyle(
                              fontSize: 25,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 10),
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
                                        'Ball Left of Size Six ',
                                        style: TextStyle(
                                          fontSize: 17,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: weight * 0.004,
                                    ),
                                    const FaIcon(
                                      FontAwesomeIcons.arrowAltCircleRight,
                                      color: Colors.black,
                                      size: 20,
                                    ),
                                    const Spacer(),
                                    Text(
                                      (_totalBallSix - _sizeSix).toString(),
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
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 10),
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
                                        'Ball Left of Size Seven ',
                                        style: TextStyle(
                                          fontSize: 17,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: weight * 0.004,
                                    ),
                                    const FaIcon(
                                      FontAwesomeIcons.arrowAltCircleRight,
                                      color: Colors.black,
                                      size: 20,
                                    ),
                                    const Spacer(),
                                    Text(
                                      (_totalBallSeven - _sizeSeven).toString(),
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
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        'Features :-',
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 60,
                        width: weight,
                        decoration: BoxDecoration(
                          color: Colors.yellow[100],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Click to issue Ball',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20),
                              ),
                            ),
                            const Spacer(),
                            RaisedButton(
                              color: Colors.red.withOpacity(0.9),
                              splashColor: Colors.red.withOpacity(0.5),
                              elevation: 10.0,
                              shape: const StadiumBorder(),
                              onPressed: () {
                                bbSixLogic(
                                    (_totalBallSix - _sizeSix).toString(),
                                    (_totalBallSeven - _sizeSeven).toString());
                              },
                              child: _isFirstView
                                  ? const Center(
                                      child: Text(
                                        'Issue Ball',
                                        style: TextStyle(
                                          color: Colors.white,
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
                                              color: Colors.white,
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
                                                  color: Colors.white,
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
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 17,
                                                    ),
                                                  ),
                                                )
                                              : Container(),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 60,
                        width: weight,
                        decoration: BoxDecoration(
                          color: Colors.yellow[100],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Count Match Score',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20),
                              ),
                            ),
                            const Spacer(),
                            RaisedButton(
                              color: Colors.red.withOpacity(0.9),
                              splashColor: Colors.red.withOpacity(0.5),
                              elevation: 10.0,
                              shape: const StadiumBorder(),
                              onPressed: () {},
                              child: const Center(
                                child: Text(
                                  'Score Tracker',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ),
                            ),
                          ],
                        ),
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

class StackContainer extends StatelessWidget {
  const StackContainer({Key? key}) : super(key: key);
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
              height: 300.0,
              width: double.infinity,
              child: Lottie.asset('assets/bb_lotty.json'),
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
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const Requested();
                }));
              },
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
          return const Requested();
        }));
        break;
      case 1:
        // print("second button is pressed");
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return const BBIssued();
        }));
        break;
      case 2:
        // print("second button is pressed");
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return const BBReturn();
        }));
        break;
    }
  }
}

class BBSixReturn extends StatelessWidget {
  String size;
  VoidCallback onTap;
  String noOfBall;
  BBSixReturn({
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
      child: Container(
        height: 150,
        width: 150,
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Text(
                    'Ball Size',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    size,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Text(
                    'Number Of Ball',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    noOfBall,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: onTap,
                  child: const Icon(
                    Icons.check_circle,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  width: 30,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child:
                      const Icon(Icons.cancel, size: 40, color: Colors.white),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
