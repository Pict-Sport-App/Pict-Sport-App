import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:psa/models/settings.dart';
import 'package:psa/services/get_settings.dart';

class Setting extends StatefulWidget {
  static const routeName = '/sport_setting';
  const Setting({Key? key}) : super(key: key);

  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  int? _bbSizeSix = Equipment.basketballsix;
  int? _bbSizeSeven = Equipment.basketballseven;
  int? _tabletennis = Equipment.tabletennis;
  int? _vollyball = Equipment.vollyball;
  int? _crixketBall=Equipment.cricketball;
  int? _cricketBat=Equipment.cricketbat;
  int? _cricketGloves=Equipment.cricketgloves;
  int? _cricketHelemt=Equipment.crickethelmet;
  int? _cricketInnerPad=Equipment.cricketinnerpad;
  int? _cricketPad=Equipment.cricketpad;
  int? _football=Equipment.football;
  final formkey = GlobalKey<FormState>();

  Future submit() async {
    try {
      if (formkey.currentState!.validate()) {
        await FirebaseFirestore.instance.collection('Settings').doc('xx').set({
          'basketball_Size_Six': _bbSizeSix,
          'basketball_Size_Seven': _bbSizeSeven,
          'tabletennis': _tabletennis,
          'vollyball': _vollyball,
          'cricket_ball':_crixketBall,
          'cricket_bat':_cricketBat,
          'cricket_gloves':_cricketGloves,
          'cricket_pad':_cricketPad,
          'cricket_innerPad':_cricketInnerPad,
          'cricket_helmet':_cricketHelemt,
          'football':_football,
        });
        getequiment();
        Navigator.pop(context);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: width,
          height: height,
          color: Colors.white,
          child: Form(
            key: formkey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(Icons.backspace_outlined)),
                      ),
                      const SportName(name: 'BasketBall', colors: Colors.redAccent,leftPad: 12,),
                      const SportName(name: 'Size 6', colors: Colors.greenAccent,leftPad: 25,),
                      Padding(
                        padding: const EdgeInsets.only(left: 30, right: 30),
                        child: TextFormField(
                          initialValue: Equipment.basketballsix.toString(),
                          onSaved: (input) {
                            _bbSizeSix = int.parse(input.toString());
                          },
                          keyboardType: TextInputType.number,
                          validator: (val) {},
                          //obscureText: true,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.sports_basketball_outlined),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 10),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xFF1A237E))),
                          ),
                          onChanged: (value) {
                            _bbSizeSix = int.parse(value.toString());
                          },
                        ),
                      ),
                      const SportName(name: 'Size 7', colors: Colors.greenAccent,leftPad: 25,),
                      Padding(
                        padding: const EdgeInsets.only(left: 30, right: 30),
                        child: TextFormField(
                          initialValue: Equipment.basketballseven.toString(),
                          onSaved: (input) {
                            _bbSizeSeven = int.parse(input.toString());
                          },
                          keyboardType: TextInputType.number,
                          validator: (val) {},
                          //obscureText: true,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.sports_basketball_outlined),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 10),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xFF1A237E))),
                          ),
                          onChanged: (value) {
                            _bbSizeSeven = int.parse(value.toString());
                          },
                        ),
                      ),
                      const SportName(name: 'TableTennis', colors: Colors.redAccent,leftPad: 12,),
                      const SportName(name: 'Racket', colors: Colors.greenAccent,leftPad: 25,),
                      Padding(
                        padding: const EdgeInsets.only(left: 30, right: 30),
                        child: TextFormField(
                          initialValue: Equipment.tabletennis.toString(),
                          keyboardType: TextInputType.number,
                          validator: (val) {},
                          onSaved: (inp) {
                            _tabletennis = int.parse(inp.toString());
                          },
                          //obscureText: true,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.sports_tennis),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 10),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xFF1A237E))),
                          ),
                          onChanged: (value) {
                            _tabletennis = int.parse(value.toString());
                          },
                        ),
                      ),
                      const SportName(name: 'VolleyBall', colors: Colors.redAccent,leftPad: 12,),
                      const SportName(name: 'Ball', colors: Colors.greenAccent,leftPad: 25,),
                      Padding(
                        padding: const EdgeInsets.only(left: 30, right: 30),
                        child: TextFormField(
                          initialValue: Equipment.vollyball.toString(),
                          keyboardType: TextInputType.number,
                          validator: (val) {},
                          onSaved: (inp) {
                            _vollyball = int.parse(inp.toString());
                          },
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.sports_volleyball_outlined),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 10),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xFF1A237E))),
                          ),
                          onChanged: (value) {
                            _vollyball = int.parse(value.toString());
                          },
                        ),
                      ),
                      const SportName(name: 'Cricket', colors: Colors.redAccent,leftPad: 12,),
                      const SportName(name: 'Ball', colors: Colors.greenAccent,leftPad: 25,),
                      Padding(
                        padding: const EdgeInsets.only(left: 30, right: 30),
                        child: TextFormField(
                          initialValue: Equipment.cricketball.toString(),
                          onSaved: (input) {
                            _crixketBall= int.parse(input.toString());
                          },
                          keyboardType: TextInputType.number,
                          validator: (val) {},
                          //obscureText: true,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.sports_cricket_outlined),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 10),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                            border: OutlineInputBorder(
                                borderSide:
                                BorderSide(color: Color(0xFF1A237E))),
                          ),
                          onChanged: (value) {
                            _crixketBall = int.parse(value.toString());
                          },
                        ),
                      ),
                      const SportName(name: 'Bat', colors: Colors.greenAccent,leftPad: 25,),
                      Padding(
                        padding: const EdgeInsets.only(left: 30, right: 30),
                        child: TextFormField(
                          initialValue: Equipment.cricketbat.toString(),
                          onSaved: (input) {
                            _cricketBat= int.parse(input.toString());
                          },
                          keyboardType: TextInputType.number,
                          validator: (val) {},
                          //obscureText: true,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.sports_cricket_outlined),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 10),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                            border: OutlineInputBorder(
                                borderSide:
                                BorderSide(color: Color(0xFF1A237E))),
                          ),
                          onChanged: (value) {
                            _cricketBat = int.parse(value.toString());
                          },
                        ),
                      ),
                      const SportName(name: 'Gloves', colors: Colors.greenAccent,leftPad: 25,),
                      Padding(
                        padding: const EdgeInsets.only(left: 30, right: 30),
                        child: TextFormField(
                          initialValue: Equipment.cricketgloves.toString(),
                          onSaved: (input) {
                            _cricketGloves= int.parse(input.toString());
                          },
                          keyboardType: TextInputType.number,
                          validator: (val) {},
                          //obscureText: true,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.sports_cricket_outlined),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 10),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                            border: OutlineInputBorder(
                                borderSide:
                                BorderSide(color: Color(0xFF1A237E))),
                          ),
                          onChanged: (value) {
                            _cricketGloves = int.parse(value.toString());
                          },
                        ),
                      ),
                      const SportName(name: 'Pad', colors: Colors.greenAccent,leftPad: 25,),
                      Padding(
                        padding: const EdgeInsets.only(left: 30, right: 30),
                        child: TextFormField(
                          initialValue: Equipment.cricketpad.toString(),
                          onSaved: (input) {
                            _cricketPad= int.parse(input.toString());
                          },
                          keyboardType: TextInputType.number,
                          validator: (val) {},
                          //obscureText: true,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.sports_cricket_outlined),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 10),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                            border: OutlineInputBorder(
                                borderSide:
                                BorderSide(color: Color(0xFF1A237E))),
                          ),
                          onChanged: (value) {
                            _cricketPad = int.parse(value.toString());
                          },
                        ),
                      ),
                      const SportName(name: 'InnerPad', colors: Colors.greenAccent,leftPad: 25,),
                      Padding(
                        padding: const EdgeInsets.only(left: 30, right: 30),
                        child: TextFormField(
                          initialValue: Equipment.cricketinnerpad.toString(),
                          onSaved: (input) {
                            _cricketInnerPad= int.parse(input.toString());
                          },
                          keyboardType: TextInputType.number,
                          validator: (val) {},
                          //obscureText: true,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.sports_cricket_outlined),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 10),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                            border: OutlineInputBorder(
                                borderSide:
                                BorderSide(color: Color(0xFF1A237E))),
                          ),
                          onChanged: (value) {
                            _cricketInnerPad = int.parse(value.toString());
                          },
                        ),
                      ),
                      const SportName(name: 'Helmet', colors: Colors.greenAccent,leftPad: 25,),
                      Padding(
                        padding: const EdgeInsets.only(left: 30, right: 30),
                        child: TextFormField(
                          initialValue: Equipment.crickethelmet.toString(),
                          onSaved: (input) {
                            _cricketHelemt= int.parse(input.toString());
                          },
                          keyboardType: TextInputType.number,
                          validator: (val) {},
                          //obscureText: true,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.sports_cricket_outlined),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 10),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                            border: OutlineInputBorder(
                                borderSide:
                                BorderSide(color: Color(0xFF1A237E))),
                          ),
                          onChanged: (value) {
                            _cricketHelemt = int.parse(value.toString());
                          },
                        ),
                      ),
                      const SportName(name: 'FootBall', colors: Colors.redAccent,leftPad: 12,),
                      const SportName(name: 'Ball', colors: Colors.greenAccent,leftPad: 25,),
                      Padding(
                        padding: const EdgeInsets.only(left: 30, right: 30),
                        child: TextFormField(
                          initialValue: Equipment.football.toString(),
                          onSaved: (input) {
                            _football= int.parse(input.toString());
                          },
                          keyboardType: TextInputType.number,
                          validator: (val) {},
                          //obscureText: true,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.sports_football_outlined),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 10),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                            border: OutlineInputBorder(
                                borderSide:
                                BorderSide(color: Color(0xFF1A237E))),
                          ),
                          onChanged: (value) {
                            _football = int.parse(value.toString());
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      submit();
                    },
                    child: Container(
                      width: 100,
                      height: 50,
                      decoration: const BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            'Submit',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
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
      ),
    );
  }
}

class SportName extends StatelessWidget {
  final String name;
  final double leftPad;
  final Color colors;
  const SportName({Key? key,
    required this.colors,
    required this.name,
    required this.leftPad}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 12,left: leftPad,bottom: 5,right: 12),
      child: Text(
        name,
        style: TextStyle(
          color: colors,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
    );
  }
}


