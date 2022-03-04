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
  final formkey = GlobalKey<FormState>();

  Future submit() async {
    try {
      if (formkey.currentState!.validate()) {
        await FirebaseFirestore.instance.collection('Settings').doc('xx').set({
          'basketball_Size_Six': _bbSizeSix,
          'basketball_Size_Seven': _bbSizeSeven,
          'tabletennis': _tabletennis,
          'vollyball': _vollyball,
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
                      const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text(
                          'BasketBall',
                          style: TextStyle(
                            color: Colors.redAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text(
                          'Size 6',
                          style: TextStyle(
                            color: Colors.redAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
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
                      const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text(
                          'Size 7',
                          style: TextStyle(
                            color: Colors.redAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
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
                      const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text(
                          'TableTennis',
                          style: TextStyle(
                            color: Colors.redAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
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
                      const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text(
                          'VollyBall',
                          style: TextStyle(
                            color: Colors.redAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
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
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
