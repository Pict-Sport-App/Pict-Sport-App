import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:psa/models/settings.dart';
import 'package:psa/models/user_details.dart';
import 'package:psa/screens/Home/Cricket/issueEquiment.dart';
import 'package:psa/screens/Home/Cricket/playing.dart';
import 'package:psa/screens/Home/Cricket/requested.dart';
import 'package:psa/screens/Home/Cricket/returned.dart';
import 'package:psa/screens/Home/table_tennis/pop_up_widget.dart';
import 'package:psa/widget/IssueEquimentButton.dart';
import 'package:psa/widget/commonSportText.dart';
import 'package:psa/widget/middlewidget.dart';
import 'package:psa/widget/topcurve.dart';

class CricketScreen extends StatefulWidget {
  const CricketScreen({Key? key}) : super(key: key);

  @override
  _CricketScreenState createState() => _CricketScreenState();
}

class _CricketScreenState extends State<CricketScreen> {
  bool _isFirstView = false;
  dynamic _ball, _bat, _innerPad, _pad, _gloves, _helmet;
  int _isRequested = 0,countRequested=0,countPlaying=0,countReturn=0;

  final _totalBall = int.parse(Equipment.cricketball.toString());
  final _totalBat = int.parse(Equipment.cricketbat.toString());
  final _totalHelmet = int.parse(Equipment.crickethelmet.toString());
  final _totalGloves = int.parse(Equipment.cricketgloves.toString());
  final _totalPad = int.parse(Equipment.cricketpad.toString());
  final _totalInnerPad = int.parse(Equipment.cricketinnerpad.toString());

  void logicCR() {
    _isFirstView
        ? Navigator.of(context).pushNamed(
            CricketIssue.routeName,
            arguments: [
              _totalBall - _ball,
              _totalBat - _bat,
              _totalGloves - _gloves,
              _totalInnerPad - _innerPad,
              _totalPad - _pad,
              _totalHelmet - _helmet
            ],
          )
        : _isRequested == 1
            ? showDialog(
                context: context,
                builder: (context) {
                  return PopUpRequest(
                      onTap: () {
                        FirebaseFirestore.instance
                            .collection('CREquipment')
                            .doc(UserDetails.uid)
                            .update({
                          'isRequested': 3,
                        });
                        setState(() {
                          _isFirstView = true;
                        });
                        Navigator.pop(context);
                      },
                      text: 'Cancel the request ! ');
                  //---------
                })
            : _isRequested == 2
                ? showDialog(
                    context: context,
                    builder: (context) {
                      return CRReturn(
                        onTap: () async {
                          await FirebaseFirestore.instance
                              .collection('CREquipment')
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
                        ball: _ball.toString(),
                        bat: _bat.toString(),
                        gloves: _gloves.toString(),
                        helmet: _helmet.toString(),
                        pad: _pad.toString(),
                        innerPad: _innerPad.toString(),
                      );
                    })
                : Navigator.of(context).pushNamed(
                    CricketIssue.routeName,
                    arguments: [
                      _totalBall - _ball,
                      _totalBat - _bat,
                      _totalGloves - _gloves,
                      _totalInnerPad - _innerPad,
                      _totalPad - _pad,
                      _totalHelmet - _helmet
                    ],
                  );
  }

  Future getStatus() async {
    var v = await FirebaseFirestore.instance
        .collection('CREquipment')
        .doc(UserDetails.uid)
        .get();
    if (v.exists) {
      _isRequested = v.get('isRequested');
      _ball = v.get('ball'.toString());
      _bat = v.get('bat'.toString());
      _gloves = v.get('gloves'.toString());
      _innerPad = v.get('innerPad'.toString());
      _pad = v.get('pad'.toString());
      _helmet = v.get('helmet'.toString());
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
          stream:
              FirebaseFirestore.instance.collection('CREquipment').snapshots(),
          builder: (ctx, userSnapshot) {
            if (userSnapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final usersnap = userSnapshot.data!.docs;

            _ball = 0;
            _bat = 0;
            _gloves = 0;
            _helmet = 0;
            _pad = 0;
            _innerPad = 0;
            countPlaying=0;countReturn=0;countRequested=0;
            for (int i = 0; i < usersnap.length; i++) {
              if (usersnap[i]['isRequested'] == 1){
                countRequested+=1;
              }
              if (usersnap[i]['isReturn']==true){
                countReturn+=1;
              }
              if (usersnap[i]['isRequested'] == 2) {
                countPlaying+=1;
                _ball += int.parse(usersnap[i]['ball'].toString());
                _bat += int.parse(usersnap[i]['bat'].toString());
                _helmet += int.parse(usersnap[i]['helmet'].toString());
                _innerPad += int.parse(usersnap[i]['innerPad'].toString());
                _pad += int.parse(usersnap[i]['pad'].toString());
                _gloves += int.parse(usersnap[i]['gloves'].toString());
              }
            }

            _ball ??= 0;
            _bat ??= 0;
            _helmet ??= 0;
            _gloves ??= 0;
            _innerPad ??= 0;
            _pad ??= 0;
            _helmet ??= 0;

            return SizedBox(
              width: width,
              height: height,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SizedBox(
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
                            name: 'Cricket',
                            tag: 'cr',
                            image: 'assets/cricket.jpg',
                          ),
                          TextCommon(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return const RequestedCricket();
                                }));
                              },
                              right: width / 1.89,
                              bottom: height*0.08,
                              name: 'Requested',
                              count: countRequested.toString()),
                          TextCommon(
                              onTap: () {
                               // Vibration.vibrate(duration: 1000);
                                // print("second button is pressed");
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return const PlayingCricket();
                                }));
                              },
                              right: width / 3.22,
                              bottom: height*0.08,
                              name: 'Issued',
                              count: countPlaying.toString()),
                          TextCommon(
                              onTap: () {
                                //Vibration.vibrate(duration: 1000);
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return const ReturnedCricket();
                                }));
                              },
                              right: width / 40,
                              bottom: height*0.08,
                              name: 'Returned',
                              count: countReturn.toString()),
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
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 0.0, vertical: 8),
                                        child: RowInfo(
                                          ball_size: 'Ball Left ',
                                          ball: (int.parse(
                                                      _totalBall.toString()) -
                                                  int.parse(_ball.toString()))
                                              .toString(),
                                          size: 65,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 18.0, vertical: 8),
                                        child: RowInfo(
                                          ball_size: 'Ball Left ',
                                          ball: (int.parse(
                                                      _totalBat.toString()) -
                                                  int.parse(_bat.toString()))
                                              .toString(),
                                          size: 65,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 18.0, vertical: 8),
                                        child: RowInfo(
                                          ball_size: 'Gloves Left',
                                          ball: (int.parse(
                                                      _totalGloves.toString()) -
                                                  int.parse(_gloves.toString()))
                                              .toString(),
                                          size: 65,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 18.0, vertical: 8),
                                        child: RowInfo(
                                          ball_size: 'Helmet Left ',
                                          ball: (int.parse(
                                                      _totalHelmet.toString()) -
                                                  int.parse(_helmet.toString()))
                                              .toString(),
                                          size: 65,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 18.0, vertical: 8),
                                        child: RowInfo(
                                          ball_size: 'InnerPad Left ',
                                          ball: (int.parse(_totalInnerPad
                                                      .toString()) -
                                                  int.parse(
                                                      _innerPad.toString()))
                                              .toString(),
                                          size: 65,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 18.0, vertical: 8),
                                        child: RowInfo(
                                          ball_size: 'Pad Left ',
                                          ball: (int.parse(
                                                      _totalPad.toString()) -
                                                  int.parse(_pad.toString()))
                                              .toString(),
                                          size: 65,
                                        ),
                                      ),
                                    ],
                                  ),
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
                                logicCR();
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

class CRReturn extends StatelessWidget {
  final String ball, bat, gloves, innerPad, pad, helmet;
  final VoidCallback onTap;
  const CRReturn(
      {Key? key,
      required this.bat,
      required this.innerPad,
      required this.pad,
      required this.gloves,
      required this.helmet,
      required this.ball,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      backgroundColor: Colors.transparent,
      child: Container(
        height: 420,
        width: 150,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(top: 20, right: 25, left: 10),
              child: SizedBox(
                child: Text(
                  "Returning",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
             Padding(
              padding: const EdgeInsets.only(top: 22, right: 25, left: 10),
              child: SizedBox(
                child: Text(
                  " ${ball.toString()}\t\t\t\t\t\tBall ",
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15, right: 25, left: 10),
              child: SizedBox(
                child: Text(
                  " ${bat.toString()}\t\t\t\t\t\tBat ",
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15, right: 25, left: 10),
              child: SizedBox(
                child: Text(
                  " ${gloves.toString()}\t\t\t\t\t\tGloves ",
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15, right: 25, left: 10),
              child: SizedBox(
                child: Text(
                  " ${helmet.toString()}\t\t\t\t\t\Helmet ",
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15, right: 25, left: 10),
              child: SizedBox(
                child: Text(
                  " ${pad.toString()}\t\t\t\t\t\Pad ",
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15, right: 25, left: 10),
              child: SizedBox(
                child: Text(
                  " ${innerPad.toString()}\t\t\t\t\t\InnerPad ",
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, right: 25, left: 10),
              child: SizedBox(
                height: 0.80,
                child: Container(
                  width: MediaQuery.of(context).size.width * .9,
                  margin:
                      const EdgeInsetsDirectional.only(start: 1.0, end: 2.0),
                  height: 2.0,
                  color: Colors.black,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, right: 5, left: 10),
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
    );
  }
}
