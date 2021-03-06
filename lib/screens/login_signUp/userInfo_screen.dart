import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:psa/services/get_user_data.dart';
import 'package:psa/widget/constants.dart';

class UserInfo extends StatefulWidget {
  const UserInfo({Key? key}) : super(key: key);

  @override
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  bool _basketball = false,
      _cricket = false,
      _football = false,
      _badminton = false,
      _volleyball = false,
      _chess = false,
      _gym = false,
      _tabletennis = false;
  String misId = '';
  Map<String, bool>? m = {
    'BasketBall': false, //🏀 BB
    'VolleyBall': false, //🏐 VB
    'TableTennis': false, //🎾 TT
    'Badminton': false, //🏸  BT
    'Cricket': false, //🏏  CR
    'FootBall': false, //⚽ FB
    'Chess': false, //♟ CH
    'Gym': false, //💪 GY
  };
  Map<String,int>? mp={
    'Official BasketBall': 0, //🏀 BB
    'Official VolleyBall': 0, //🏐 VB
    'Official TableTennis': 0, //🎾 TT
    'Official Badminton': 0, //🏸  BT
    'Official Cricket': 0, //🏏  CR
    'Official FootBall': 0, //⚽ FB
    'Official Chess': 0, //♟ CH
    'Official Gym': 0, //💪 GY
  };

  Widget onClick(bool onp) {
    return onp
        ? const Icon(
            Icons.check_circle,
            color: Colors.green,
            size: 30,
          )
        : const Icon(
            Icons.cancel,
            color: Colors.red,
            size: 30,
          );
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          height: height,
          width: width,
          decoration: const BoxDecoration(
            gradient: // LinearGradient(colors: [Color(0xFF4b6cb7), Color(0xFF182848)])),
            LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Color(0xFFF3E5F5),
                  //Color(0xFFCE93D8),
                  Color(0xFFCE93D8),
                  Color(0xFFBA68C8),
                  Color(0xFF9C27B0),
                ]),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Please Complete The',
                  style: TextStyle(
                    color: Color(0xFF880E4F),
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  'SignUp Process',
                  style: TextStyle(
                    color: Color(0xFF880E4F),
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 30, right: 30),
                      child: Text(
                        'MIS-ID',
                        style:
                            TextStyle(color: Color(0xFF880E4F), fontSize: 17),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30, right: 30),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        validator: (val) {
                          if (val!.length < 23) {
                            return "MIS ID cannot be too short "
                                "mis id should end with @mis.pict.edu";
                          } else if (val.length > 23) {
                            return "MIS ID cannot be that long";
                          } else if (!val.endsWith('@ms.pict.edu')) {
                            return "Please enter valid MIS ID";
                          }else if (!val.startsWith('C2K') &&!val.startsWith('c2k')
                          && !val.startsWith('c2K') && !val.startsWith('C2k') &&
                              !val.startsWith('I2K') &&!val.startsWith('i2k')
                              && !val.startsWith('i2K') && !val.startsWith('I2k') &&
                              !val.startsWith('E2K') &&!val.startsWith('e2k')
                              && !val.startsWith('e2K') && !val.startsWith('E2k')){
                            return "Enter correct mis id";
                          }
                          return null;
                        },
                        //obscureText: true,
                        decoration: const InputDecoration(
                          prefixIcon: Padding(
                            padding:
                                EdgeInsets.only(left: 10.0, top: 8, bottom: 3),
                            child: FaIcon(
                              FontAwesomeIcons.solidEnvelope,
                              color: Colors.brown,
                              size: 30,
                            ),
                          ),
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                            ),
                          ),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF1A237E))),
                        ),
                        onChanged: (value) {
                          misId = value;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaY: 16,
                      sigmaX: 16,
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'Select the Sports ',
                          style: TextStyle(
                            color: Color(0xFF880E4F),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          'You are Intersected in ',
                          style: TextStyle(
                            color: Color(0xFF880E4F),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 50, right: 50),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'BasketBall',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Row(
                                children: [
                                  const Text(''),
                                  Switch(
                                    splashRadius: 30,
                                    activeColor: Colors.green,
                                    inactiveThumbColor: Colors.red,
                                    value: _basketball,
                                    onChanged: (value) {
                                      setState(() {
                                        _basketball = value;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 50, right: 50, top: 0),
                          child: Divider(
                            thickness: 1,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 50, right: 50),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Table Tennis',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Row(
                                children: [
                                  const Text(''),
                                  Switch(
                                    splashRadius: 30,
                                    activeColor: Colors.green,
                                    inactiveThumbColor: Colors.red,
                                    value: _tabletennis,
                                    onChanged: (value) {
                                      setState(() {
                                        _tabletennis = value;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 50, right: 50, top: 0),
                          child: Divider(
                            thickness: 1,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 50, right: 50),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Cricket',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Row(
                                children: [
                                  const Text(''),
                                  Switch(
                                    splashRadius: 30,
                                    activeColor: Colors.green,
                                    inactiveThumbColor: Colors.red,
                                    value: _cricket,
                                    onChanged: (value) {
                                      setState(() {
                                        _cricket = value;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 50, right: 50, top: 0),
                          child: Divider(
                            thickness: 1,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 50, right: 50),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Badminton',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Row(
                                children: [
                                  const Text(''),
                                  Switch(
                                    splashRadius: 30,
                                    activeColor: Colors.green,
                                    inactiveThumbColor: Colors.red,
                                    value: _badminton,
                                    onChanged: (value) {
                                      setState(() {
                                        _badminton = value;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 50, right: 50, top: 0),
                          child: Divider(
                            thickness: 1,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 50, right: 50),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'VolleyBall',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Row(
                                children: [
                                  const Text(''),
                                  Switch(
                                    splashRadius: 30,
                                    activeColor: Colors.green,
                                    inactiveThumbColor: Colors.red,
                                    value: _volleyball,
                                    onChanged: (value) {
                                      setState(() {
                                        _volleyball = value;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 50, right: 50, top: 0),
                          child: Divider(
                            thickness: 1,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 50, right: 50),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Chess',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Row(
                                children: [
                                  const Text(''),
                                  Switch(
                                    splashRadius: 30,
                                    activeColor: Colors.green,
                                    inactiveThumbColor: Colors.red,
                                    value: _chess,
                                    onChanged: (value) {
                                      setState(() {
                                        _chess = value;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 50, right: 50, top: 0),
                          child: Divider(
                            thickness: 1,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 50, right: 50),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Gym',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Row(
                                children: [
                                  const Text(''),
                                  Switch(
                                    splashRadius: 30,
                                    activeColor: Colors.green,
                                    inactiveThumbColor: Colors.red,
                                    value: _gym,
                                    onChanged: (value) {
                                      setState(() {
                                        _gym = value;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 50, right: 50, top: 0),
                          child: Divider(
                            thickness: 1,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 50, right: 50),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Football',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Row(
                                children: [
                                  const Text(''),
                                  Switch(
                                    splashRadius: 30,
                                    activeColor: Colors.green,
                                    inactiveThumbColor: Colors.red,
                                    value: _football,
                                    onChanged: (value) {
                                      setState(() {
                                        _football = value;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 50, right: 50, top: 5),
                          child: Divider(
                            thickness: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 70,
                  child: FlatButton(
                    onPressed: () {

                      if (misId.length < 23) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('MIS ID cannot be that small .Mis Id should end with @mis.pict.edu')));
                      } else if (misId.length > 23) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('MIS ID cannot be that long')));
                      }else if (!misId.startsWith('C2K') &&!misId.startsWith('c2k')
                          && !misId.startsWith('c2K') && !misId.startsWith('C2k') &&
                          !misId.startsWith('I2K') &&!misId.startsWith('i2k')
                          && !misId.startsWith('i2K') && !misId.startsWith('I2k') &&
                          !misId.startsWith('E2K') &&!misId.startsWith('e2k')
                          && !misId.startsWith('e2K') && !misId.startsWith('E2k')){
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('PLease enter correct email id ')));
                      } else {
                        //print(UserDetails.sportList?.update(key, (value) => false));
                        if (_basketball) {
                          m?.update('BasketBall', (value) => true);
                        }else{
                          mp?.update('Official BasketBall', (value) => -1);
                        }
                        if (_football) {
                          m?.update('FootBall', (value) => true);
                        }else{
                          mp?.update('Official FootBall', (value) => -1);
                        }
                        if (_volleyball) {
                          m?.update('VolleyBall', (value) => true);
                        }else{
                          mp?.update('Official VolleyBall', (value) => -1);
                        }
                        if (_cricket) {
                          m?.update('Cricket', (value) => true);
                        }else{
                          mp?.update('Official Cricket', (value) => -1);
                        }
                        if (_chess) {
                          m?.update('Chess', (value) => true);
                        }else{
                          mp?.update('Official Chess', (value) => -1);
                        }
                        if (_gym) {
                          m?.update('Gym', (value) => true);
                        }else{
                          mp?.update('Official Gym', (value) => -1);
                        }
                        if (_tabletennis) {
                          m?.update('TableTennis', (value) => true);
                        }else{
                          mp?.update('Official TableTennis', (value) => -1);
                        }
                        if (_badminton) {
                          m?.update('Badminton', (value) => true);
                        }else{
                          mp?.update('Official Badminton', (value) => -1);
                        }
                        User? user = FirebaseAuth.instance.currentUser;
                        var uid = user?.uid;
                        FirebaseFirestore.instance
                            .collection('User')
                            .doc(uid)
                            .set({
                          'name': user?.displayName,
                          'photourl': user?.photoURL,
                          'email': user?.email,
                          'uid': user?.uid,
                          'misId': misId,
                          'SportList': m,
                          'isAdmin': false,
                          'isDeveloper':false,
                          'Official SportList':mp,
                        });
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) {
                          return GetUserData();
                        }));
                      }
                    },
                    shape: const StadiumBorder(),
                    color: Colors.redAccent,
                    child: Text(
                      'SUBMIT',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
