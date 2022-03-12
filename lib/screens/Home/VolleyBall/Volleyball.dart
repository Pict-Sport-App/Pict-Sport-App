import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:psa/models/settings.dart';
import 'package:psa/models/user_details.dart';
import 'package:psa/screens/Home/VolleyBall/issue_ball.dart';
import 'package:psa/screens/Home/VolleyBall/playing.dart';
import 'package:psa/screens/Home/VolleyBall/requested.dart';
import 'package:psa/screens/Home/VolleyBall/returned.dart';
import 'package:psa/screens/Home/table_tennis/pop_up_widget.dart';
import 'package:psa/widget/IssueEquimentButton.dart';
import 'package:psa/widget/commonSportText.dart';
import 'package:psa/widget/middlewidget.dart';
import 'package:psa/widget/topcurve.dart';

class VolleyBallScreen extends StatefulWidget {
  const VolleyBallScreen({Key? key}) : super(key: key);

  @override
  _VolleyBallScreenState createState() => _VolleyBallScreenState();
}

class _VolleyBallScreenState extends State<VolleyBallScreen> {
  bool _isFirstView = false;
  dynamic _noOfBall,_n;
  int _isRequested = 0;
  final _totalBall = int.parse(Equipment.vollyball.toString());

  void logicVV() {
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
  }

  Future getStatus() async {
    var v = await FirebaseFirestore.instance
        .collection('VVEquipment')
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
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder<QuerySnapshot>(
          stream:
              FirebaseFirestore.instance.collection('VVEquipment')
                  .snapshots(),
          builder: (ctx, userSnapshot) {
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
            return SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    color: Colors.lightGreen,
                    width: MediaQuery.of(context).size.width,
                    height: height*0.4,//320,
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
                        const TopName(name: 'VolleyBall',
                        image: 'assets/volleyball.jpg',),
                        TextCommon(onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return const RequestedVolly();
                          }));
                        },
                            right: width/1.89,
                            bottom: 80,
                            name: 'Requested',
                            count: '2'),
                        TextCommon(onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return const PlayingVolly();
                          }));
                        },
                            right: width/3.22,
                            bottom: 80,
                            name: 'Issued',
                            count: '45'),
                        TextCommon(onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return const ReturnVolly();
                          }));
                        },
                            right: width/40,
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
                            padding: const EdgeInsets.only(left: 28.0),
                            child: SizedBox(
                              // color: Colors.red,
                              height: height * 0.4,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  MiddleWidget(number: (_totalBall-_n).toString(),
                                      text1: 'Ball Left')

                                ],
                              ),
                            ),
                          ),
                        ),
                        IssueEquimentWidget(
                            name:  _isFirstView?
                            const Button(name: 'Issue')
                            :_isRequested==1?
                            const Button(name: 'Cancel Request'):
                            _isRequested == 2?
                            const Button(name: 'Return Ball'):
                            _isRequested==4?
                            const Button(name: 'Issue'):Container(),
                            onTap: (){
                          logicVV();
                        })
                      ],
                    ),
                  ),
                  // assets/bottom2.jpg
                ],
              ),
            );
          }),
    );
  }
}

class VVReturn extends StatelessWidget {
  late String noOfBall;
  late VoidCallback onTap;
  VVReturn({Key? key, required this.noOfBall, required this.onTap})
      : super(key: key);

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
