import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:psa/models/settings.dart';
import 'package:psa/models/user_details.dart';
import 'package:psa/screens/Home/Cricket/issueEquiment.dart';
import 'package:psa/screens/Home/Cricket/playing.dart';
import 'package:psa/screens/Home/Cricket/requested.dart';
import 'package:psa/screens/Home/Cricket/returned.dart';
import 'package:psa/screens/Home/table_tennis/pop_up_widget.dart';
import 'package:psa/screens/otherUserDetails/helper/custom_clipper.dart';

class CricketScreen extends StatefulWidget {
  const CricketScreen({Key? key}) : super(key: key);

  @override
  _CricketScreenState createState() => _CricketScreenState();
}

class _CricketScreenState extends State<CricketScreen> {
  bool _isFirstView = false;
  dynamic _ball,_bat,_innerPad,_pad,_gloves,_helmet;
  dynamic _cball,_cbat,_cinnerPad,_cpad,_cgloves,_chelmet;
  int _isRequested = 0;


  final _totalBall = int.parse(Equipment.cricketball.toString());
  final _totalBat=int.parse(Equipment.cricketbat.toString());
  final _totalHelmet=int.parse(Equipment.crickethelmet.toString());
  final _totalGloves=int.parse(Equipment.cricketgloves.toString());
  final _totalPad=int.parse(Equipment.cricketpad.toString());
  final _totalInnerPad=int.parse(Equipment.cricketinnerpad.toString());

  void logicCR() {
    _isFirstView
        ? Navigator.of(context).pushNamed(
      CricketIssue.routeName,
      arguments: [_totalBall-_cball,
      _totalBat-_cbat,
      _totalGloves-_cgloves,
      _totalInnerPad-_cinnerPad,
      _totalPad-_cpad,
      _totalHelmet-_chelmet],
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
              text: 'Want to cancel the request');
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
            ball: _ball,
            bat: _bat,
            gloves: _gloves, helmet: _helmet,
            pad: _pad,
            innerPad: _innerPad,
          );
        })
        : Navigator.of(context).pushNamed(
      CricketIssue.routeName,
      arguments: [_totalBall-_cball,
        _totalBat-_cbat,
        _totalGloves-_cgloves,
        _totalInnerPad-_cinnerPad,
        _totalPad-_cpad,
        _totalHelmet-_chelmet],
    );
  }

  Future getStatus() async {
    var v = await FirebaseFirestore.instance
        .collection('CREquipment')
        .doc(UserDetails.uid)
        .get();
    if (v.exists) {
      _isRequested = v.get('isRequested');
      _ball = v.get('ball');
      _bat=v.get('bat');
      _gloves=v.get('gloves');
      _innerPad=v.get('innerPad');
      _pad=v.get('pad');
      _helmet=v.get('helmet');
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
          FirebaseFirestore.instance.collection('CREquipment')
              .snapshots(),
          builder: (ctx, userSnapshot){
            if (userSnapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final usersnap = userSnapshot.data!.docs;
            _cball=0;_cbat=0;_cgloves=0;
            _chelmet=0;_cpad=0;_cinnerPad=0;
            for (int i = 0; i < usersnap.length; i++) {
              if (usersnap[i]['isRequested'] == 2) {
                _cball += int.parse(usersnap[i]['ball']);
                _cbat += int.parse(usersnap[i]['bat']);
                _chelmet += int.parse(usersnap[i]['helmet']);
                _cinnerPad += int.parse(usersnap[i]['innerPad']);
                _cpad += int.parse(usersnap[i]['pad']);
                _cgloves += int.parse(usersnap[i]['gloves']);
              }
            }
            return Column(
              children: [
                const UpperCricket(),
                RaisedButton(onPressed: (){
                  logicCR();
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
                  ),)
              ],
            );
          }
      ),
    );
  }
}

class CRReturn extends StatelessWidget {
  final String ball,bat,gloves,innerPad,pad,helmet;
  final VoidCallback onTap;
  const CRReturn({Key? key,
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
       height: 300,
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
                    ball,
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
                    'Number Of Bat',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    bat,
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
                    'Number Of Gloves',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    gloves,
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
                    'Number Of Helmet',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    helmet,
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
                    'Number Of Pad',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    pad,
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
                    'Number Of InnerPad',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    innerPad,
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
