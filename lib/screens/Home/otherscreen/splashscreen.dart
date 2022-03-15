import 'package:flutter/material.dart';
import 'package:psa/services/get_user_data.dart';

class splash_screen extends StatefulWidget {
  const splash_screen({ Key? key }) : super(key: key);

  @override
  State<splash_screen> createState() => _splash_screenState();
}

class _splash_screenState extends State<splash_screen> {
  @override
  void initState(){
    super.initState();
    autroute();
  }

  void autroute() async {
    await Future.delayed(const Duration(milliseconds: 3000), () {});
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder:
        (context) => GetUserData()));//place your page here
  }
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(child:Image.asset('assets/animate.gif'),),
      ),
    );
  }
}
