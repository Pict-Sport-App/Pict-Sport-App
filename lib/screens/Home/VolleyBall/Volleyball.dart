import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:psa/models/settings.dart';
import 'package:psa/models/userDetails.dart';
import 'package:psa/screens/Home/VolleyBall/issueBall.dart';
import 'package:psa/screens/Home/VolleyBall/playing.dart';
import 'package:psa/screens/Home/VolleyBall/requested.dart';
import 'package:psa/screens/Home/VolleyBall/returned.dart';
import 'package:psa/screens/Home/table_tennis/popUpWidget.dart';
import 'package:psa/screens/otherUserDetails/helper/custom_clipper.dart';

class VolleyBall_Screen extends StatefulWidget {
  const VolleyBall_Screen({Key? key}) : super(key: key);

  @override
  _VolleyBall_ScreenState createState() => _VolleyBall_ScreenState();
}

class _VolleyBall_ScreenState extends State<VolleyBall_Screen> {
  bool _isFirstView = false;
  var _noOfBall;
  int _isRequested = 0;
  late var _n;

  final _totalBall = int.parse(Equipment.vollyball.toString());

  void Logic_VV(){
    _isFirstView
        ? Navigator.of(context).pushNamed(
      Issue.routeName,
      arguments: _totalBall-_n,
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
              print('return');
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
      arguments: _totalBall-_n,
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
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('VVEquipment').snapshots(),
        builder:(ctx, userSnapshot){
          if (userSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final usersnap = userSnapshot.data!.docs;
          _n=0;
          for (int i = 0; i < usersnap.length; i++) {
              if (usersnap[i]['isRequested'] == 2) {
                _n += int.parse(usersnap[i]['noOfBall']);
              }
          }
          return Column(
            children: [
              const UpperVolly(),
              Padding(
                padding: const EdgeInsets.only(left: 20,right: 20,top: 10),
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
              const SizedBox(height: 10,),
              Container(
                width: width*0.4,
                //color: Colors.red,
                child: RaisedButton(onPressed: (){
                 Logic_VV();
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
                  ),),
              ),
            ],
          );
        }
      ),
    );
  }
}

class UpperVolly extends StatefulWidget {
  const UpperVolly({Key? key}) : super(key: key);

  @override
  _UpperVollyState createState() => _UpperVollyState();
}

class _UpperVollyState extends State<UpperVolly> {
  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    return Container(
      height: 390.0,
      child: Stack(
        children: <Widget>[
          ClipPath(
            clipper: MyCustomClipper(),
            child: Container(
              height: 350.0,
              width: double.infinity,
              child: Lottie.asset('assets/vollyLofy.json'),
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
        print("First button is pressed");
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return const RequestedVolly();
        }));
        break;
      case 1:
        print("second button is pressed");
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return const PlayingVolly();
        }));
        break;
      case 2:
        print("second button is pressed");
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return const ReturnVolly();
        }));
        break;
    }
  }
}

class VVReturn extends StatelessWidget {

  late String noOfBall;
  late VoidCallback onTap;
  VVReturn({required this.noOfBall,required this.onTap});

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
